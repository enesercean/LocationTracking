using System;
using System.Threading;
using System.Threading.Tasks;
using LocationTrackingMApp.Constants;
using LocationTrackingMApp.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Maui.Devices.Sensors;
using Microsoft.Maui.ApplicationModel;

namespace LocationTrackingMApp.Services
{
    public class LocationChangedEventArgs : EventArgs
    {
        public Location Location { get; set; }
        public bool IsError { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class LocationService
    {
        private readonly SignalRService _signalRService;
        private readonly ILogger<LocationService> _logger;
        private CancellationTokenSource _cancellationTokenSource;
        private bool _isTracking = false;
        private string _deviceId;
        private string _deviceName;
        private Location _lastKnownLocation;
        private int _retryCount = 0;

        public bool IsTracking => _isTracking;
        public Location LastKnownLocation => _lastKnownLocation;

        // Event for location updates that UI can subscribe to
        public event EventHandler<LocationChangedEventArgs> LocationChanged;

        public LocationService(SignalRService signalRService, ILogger<LocationService> logger)
        {
            _signalRService = signalRService;
            _logger = logger;

            // Generate a unique device ID or retrieve it from secure storage
            _deviceId = Guid.NewGuid().ToString();
            _deviceName = DeviceInfo.Name;
            
            // Initialize with default location (will be replaced on first update)
            _lastKnownLocation = new Location(0, 0);
        }

        public async Task StartTrackingAsync()
        {
            if (_isTracking)
                return;

            _isTracking = true;
            _cancellationTokenSource = new CancellationTokenSource();

            try
            {
                // Check and request location permissions
                var status = await CheckAndRequestLocationPermission();
                if (status != PermissionStatus.Granted)
                {
                    _logger.LogWarning("Location permission not granted");
                    _isTracking = false;
                    
                    // Notify subscribers about permission error
                    LocationChanged?.Invoke(this, new LocationChangedEventArgs
                    {
                        Location = _lastKnownLocation,
                        IsError = true,
                        ErrorMessage = "Location permission not granted"
                    });
                    
                    return;
                }

                // Register device with hub
                await RegisterDeviceAsync();

                // Start location tracking
                await TrackLocationAsync(_cancellationTokenSource.Token);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error starting location tracking: {ex.Message}");
                _isTracking = false;
                _cancellationTokenSource?.Cancel();
                
                // Notify subscribers about error
                LocationChanged?.Invoke(this, new LocationChangedEventArgs
                {
                    Location = _lastKnownLocation,
                    IsError = true,
                    ErrorMessage = $"Failed to start tracking: {ex.Message}"
                });
            }
        }

        public void StopTracking()
        {
            if (!_isTracking)
                return;

            _isTracking = false;
            _cancellationTokenSource?.Cancel();
            _logger.LogInformation("Location tracking stopped");
            
            // Unsubscribe from events when stopping
            Geolocation.LocationChanged -= OnGeolocationChanged;
        }

        private async Task<PermissionStatus> CheckAndRequestLocationPermission()
        {
            var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();

            if (status != PermissionStatus.Granted)
            {
                status = await Permissions.RequestAsync<Permissions.LocationWhenInUse>();
            }

            return status;
        }

        private async Task RegisterDeviceAsync()
        {
            var registrationDto = new DeviceRegistrationDto
            {
                DeviceId = _deviceId,
                DeviceName = _deviceName
            };

            await _signalRService.RegisterDeviceAsync(registrationDto);
        }

        private async Task TrackLocationAsync(CancellationToken cancellationToken)
        {
            try
            {
                // Initial location update
                await UpdateCurrentLocationAsync();

                // Configure continuous listening options
                var request = new GeolocationListeningRequest
                {
                    MinimumTime = TimeSpan.FromSeconds(AppSettings.LocationUpdateIntervalSeconds),
                    DesiredAccuracy = GeolocationAccuracy.Best
                };

                // Subscribe to location changes
                Geolocation.LocationChanged += OnGeolocationChanged;

                await Geolocation.StartListeningForegroundAsync(request);

                while (_isTracking && !cancellationToken.IsCancellationRequested)
                {
                    await Task.Delay(30000, cancellationToken); // Fallback update every 30 seconds
                    await UpdateCurrentLocationAsync();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error in location tracking: {ex.Message}");
                LocationChanged?.Invoke(this, new LocationChangedEventArgs
                {
                    Location = _lastKnownLocation,
                    IsError = true,
                    ErrorMessage = $"Location tracking error: {ex.Message}"
                });
            }
            finally
            {
                Geolocation.StopListeningForeground();
            }
        }

        private void OnGeolocationChanged(object sender, GeolocationLocationChangedEventArgs args)
        {
            _ = HandleNewLocation(args.Location);
        }

        private async Task UpdateCurrentLocationAsync()
        {
            try
            {
                _retryCount = 0;
                await GetLocationWithRetryAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error getting current location after retries: {ex.Message}");
                // Notify UI that we're using last known or default location
                LocationChanged?.Invoke(this, new LocationChangedEventArgs
                {
                    Location = _lastKnownLocation,
                    IsError = true,
                    ErrorMessage = "Unable to get current location"
                });
            }
        }

        private async Task GetLocationWithRetryAsync()
        {
            try
            {
                var request = new GeolocationRequest
                {
                    DesiredAccuracy = GeolocationAccuracy.Best,
                    Timeout = TimeSpan.FromSeconds(AppSettings.LocationTimeoutSeconds)
                };

                var location = await Geolocation.GetLocationAsync(request);

                if (location != null)
                {
                    await HandleNewLocation(location);
                    _retryCount = 0;
                }
                else if (_retryCount < AppSettings.MaxLocationRetries)
                {
                    _retryCount++;
                    _logger.LogWarning($"Location is null, retrying ({_retryCount}/{AppSettings.MaxLocationRetries})...");
                    await Task.Delay(TimeSpan.FromSeconds(AppSettings.LocationRetryDelaySeconds));
                    await GetLocationWithRetryAsync();
                }
                else
                {
                    throw new Exception("Failed to get location after maximum retries");
                }
            }
            catch (Exception ex)
            {
                if (_retryCount < AppSettings.MaxLocationRetries)
                {
                    _retryCount++;
                    _logger.LogWarning($"Error getting location, retrying ({_retryCount}/{AppSettings.MaxLocationRetries}): {ex.Message}");
                    await Task.Delay(TimeSpan.FromSeconds(AppSettings.LocationRetryDelaySeconds));
                    await GetLocationWithRetryAsync();
                }
                else
                {
                    throw;
                }
            }
        }

        private async Task HandleNewLocation(Location location)
        {
            try
            {
                // Update last known location
                _lastKnownLocation = location;
                
                // Notify any subscribers (UI components)
                LocationChanged?.Invoke(this, new LocationChangedEventArgs
                {
                    Location = location,
                    IsError = false
                });
                
                // Send to backend
                await SendLocationUpdateAsync(location);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error handling new location: {ex.Message}");
            }
        }

        private async Task SendLocationUpdateAsync(Location location)
        {
            try
            {
                var batteryLevel = "Unknown";
                try
                {
                    var batteryInfo = Battery.ChargeLevel;
                    batteryLevel = $"{batteryInfo * 100:0}%";
                }
                catch
                {
                    // Battery info not available
                }

                var locationUpdate = new LocationUpdateDto
                {
                    DeviceId = _deviceId,
                    Latitude = location.Latitude,
                    Longitude = location.Longitude,
                    Altitude = location.Altitude,
                    Speed = location.Speed,
                    Accuracy = location.Accuracy,
                    BatteryLevel = batteryLevel
                };

                await _signalRService.UpdateLocationAsync(locationUpdate);
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error sending location update: {ex.Message}");
            }
        }
    }
}
