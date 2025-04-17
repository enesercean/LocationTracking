using System;
using System.Threading;
using System.Threading.Tasks;
using LocationTrackingMApp.Constants;
using LocationTrackingMApp.Models;
using Microsoft.AspNetCore.SignalR.Client;
using Microsoft.Extensions.Logging;

namespace LocationTrackingMApp.Services
{
    public class SignalRService
    {
        private HubConnection _hubConnection;
        private readonly string _baseUrl;
        private readonly ILogger<SignalRService> _logger;
        private CancellationTokenSource _cancellationTokenSource;
        private bool _isConnected = false;
        private int _reconnectAttempts = 0;
        private const int _maxReconnectAttempts = 5;

        public bool IsConnected => _isConnected;

        public SignalRService(ILogger<SignalRService> logger)
        {
            _logger = logger;
            _baseUrl = AppSettings.ApiBaseUrl; // Use configurable URL
            _cancellationTokenSource = new CancellationTokenSource();
            InitializeConnection();
        }

        private void InitializeConnection()
        {
            try
            {
                _hubConnection = new HubConnectionBuilder()
                    .WithUrl($"{_baseUrl}/locationHub")
                    .WithAutomaticReconnect(new[] { TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(5), TimeSpan.FromSeconds(10), TimeSpan.FromSeconds(30) })
                    .Build();

                _hubConnection.Closed += async (error) =>
                {
                    _isConnected = false;
                    _logger.LogWarning($"Connection closed: {error?.Message}");
                    await Task.Delay(5000);
                    await ReconnectAsync();
                };
                
                _logger.LogInformation($"SignalR connection initialized with server: {_baseUrl}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Failed to initialize SignalR connection: {ex.Message}");
            }
        }

        public async Task ConnectAsync()
        {
            if (_hubConnection.State == HubConnectionState.Connected)
                return;

            try
            {
                await _hubConnection.StartAsync(_cancellationTokenSource.Token);
                _isConnected = true;
                _reconnectAttempts = 0;
                _logger.LogInformation("Connected to SignalR hub");
            }
            catch (Exception ex)
            {
                _isConnected = false;
                _logger.LogError($"Error connecting to SignalR hub: {ex.Message}");
                throw;
            }
        }

        public async Task DisconnectAsync()
        {
            if (_hubConnection.State == HubConnectionState.Disconnected)
                return;

            try
            {
                await _hubConnection.StopAsync(_cancellationTokenSource.Token);
                _isConnected = false;
                _logger.LogInformation("Disconnected from SignalR hub");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error disconnecting from SignalR hub: {ex.Message}");
            }
        }

        private async Task ReconnectAsync()
        {
            try
            {
                if (_reconnectAttempts >= _maxReconnectAttempts)
                {
                    _logger.LogError($"Failed to reconnect after {_maxReconnectAttempts} attempts");
                    return;
                }
                
                _reconnectAttempts++;
                await _hubConnection.StartAsync();
                _isConnected = true;
                _reconnectAttempts = 0;
                _logger.LogInformation("Reconnected to SignalR hub");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Failed to reconnect (attempt {_reconnectAttempts}): {ex.Message}");
                await Task.Delay(Math.Min(1000 * _reconnectAttempts, 5000));
                await ReconnectAsync();
            }
        }

        public async Task RegisterDeviceAsync(DeviceRegistrationDto registrationDto)
        {
            if (!_isConnected)
                await ConnectAsync();

            try
            {
                await _hubConnection.InvokeAsync("RegisterDevice", registrationDto);
                _logger.LogInformation($"Device registered: {registrationDto.DeviceId}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error registering device: {ex.Message}");
                throw; // Propagate the error for better handling
            }
        }

        public async Task UpdateLocationAsync(LocationUpdateDto locationUpdate)
        {
            if (!_isConnected)
                await ConnectAsync();

            try
            {
                await _hubConnection.InvokeAsync("UpdateLocation", locationUpdate);
                _logger.LogInformation($"Location updated: {locationUpdate.Latitude}, {locationUpdate.Longitude}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error updating location: {ex.Message}");
                throw; // Propagate the error for better handling
            }
        }

        public void Dispose()
        {
            _cancellationTokenSource?.Cancel();
            _cancellationTokenSource?.Dispose();
            _ = _hubConnection?.DisposeAsync();
        }
    }
}
