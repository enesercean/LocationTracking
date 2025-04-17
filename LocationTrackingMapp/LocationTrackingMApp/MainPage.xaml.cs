using System;
using LocationTrackingMApp.Services;
using Microsoft.Maui.Devices.Sensors;
using Microsoft.Extensions.Logging;

namespace LocationTrackingMApp
{
    public partial class MainPage : ContentPage
    {
        private readonly LocationService _locationService;
        private readonly SignalRService _signalRService;
        private readonly ILogger<MainPage> _logger;
        private bool _initialLocationRequested = false;

        public MainPage(LocationService locationService, SignalRService signalRService, ILogger<MainPage> logger)
        {
            InitializeComponent();
            _locationService = locationService;
            _signalRService = signalRService;
            _logger = logger;
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            UpdateConnectionStatus();
            
            // Subscribe to our custom location changed event
            _locationService.LocationChanged += OnLocationServiceLocationChanged;
            
            // If tracking is already active, update UI
            TrackingSwitch.IsToggled = _locationService.IsTracking;
            UpdateUiState();
            
            if (!_initialLocationRequested)
            {
                _initialLocationRequested = true;
                
                try
                {
                    // Request first location when page appears
                    var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();
                    if (status == PermissionStatus.Granted)
                    {
                        LocationText.Text = "Getting initial location...";
                        var location = await Geolocation.GetLastKnownLocationAsync();
                        if (location != null)
                        {
                            UpdateLocationDisplay(location);
                            LocationText.Text = "Using last known location";
                        }
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogWarning($"Could not get initial location: {ex.Message}");
                }
            }
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
            
            // Unsubscribe from our custom event
            _locationService.LocationChanged -= OnLocationServiceLocationChanged;
        }

        private void OnLocationServiceLocationChanged(object sender, LocationChangedEventArgs e)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (e.IsError)
                {
                    StatusLabel.Text = $"Status: Error - {e.ErrorMessage}";
                }
                else
                {
                    UpdateLocationDisplay(e.Location);
                    StatusLabel.Text = $"Status: {(_signalRService.IsConnected ? "Connected" : "Disconnected")}";
                    LocationText.Text = "Location updated";
                }
            });
        }

        private async void OnTrackingSwitchToggled(object sender, ToggledEventArgs e)
        {
            if (e.Value)
            {
                LocationText.Text = "Starting location tracking...";
                try
                {
                    await _locationService.StartTrackingAsync();
                    
                    if (_locationService.IsTracking)
                    {
                        LocationText.Text = "Location tracking is active";
                    }
                    else
                    {
                        LocationText.Text = "Failed to start tracking";
                        TrackingSwitch.IsToggled = false;
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError($"Failed to start tracking: {ex.Message}");
                    await DisplayAlert("Error", $"Failed to start location tracking: {ex.Message}", "OK");
                    TrackingSwitch.IsToggled = false;
                    LocationText.Text = "Location tracking failed";
                }
            }
            else
            {
                _locationService.StopTracking();
                LocationText.Text = "Location tracking is disabled";
            }

            UpdateUiState();
        }

        private async void OnConnectButtonClicked(object sender, EventArgs e)
        {
            if (_signalRService.IsConnected)
            {
                await _signalRService.DisconnectAsync();
                ConnectButton.Text = "Connect to Server";
            }
            else
            {
                try
                {
                    ConnectButton.IsEnabled = false;
                    ConnectButton.Text = "Connecting...";
                    
                    await _signalRService.ConnectAsync();
                    
                    ConnectButton.Text = "Disconnect from Server";
                    ConnectButton.IsEnabled = true;
                }
                catch (Exception ex)
                {
                    _logger.LogError($"Failed to connect: {ex.Message}");
                    await DisplayAlert("Connection Error", $"Could not connect to the server: {ex.Message}", "OK");
                    ConnectButton.Text = "Connect to Server";
                    ConnectButton.IsEnabled = true;
                }
            }

            UpdateConnectionStatus();
        }

        private void UpdateLocationDisplay(Location location)
        {
            if (location == null) return;
            
            LatitudeLabel.Text = $"Latitude: {location.Latitude:F6}";
            LongitudeLabel.Text = $"Longitude: {location.Longitude:F6}";
            AltitudeLabel.Text = $"Altitude: {(location.Altitude.HasValue ? $"{location.Altitude:F1} m" : "-")}";
            AccuracyLabel.Text = $"Accuracy: {(location.Accuracy.HasValue ? $"{location.Accuracy:F1} m" : "-")}";
            
            // If we have a last location from the service, update the UI
            if (_locationService.LastKnownLocation != null && !_locationService.IsTracking)
            {
                LocationText.Text = "Using last known location";
            }
        }

        private void UpdateConnectionStatus()
        {
            StatusLabel.Text = $"Status: {(_signalRService.IsConnected ? "Connected" : "Disconnected")}";
        }

        private void UpdateUiState()
        {
            ConnectButton.IsEnabled = !TrackingSwitch.IsToggled || _signalRService.IsConnected;
        }
    }
}
