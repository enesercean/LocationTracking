using Microsoft.AspNetCore.SignalR;
using LocationTrackingAPI.Models;
using LocationTrackingAPI.Data;
using System;
using System.Threading.Tasks;

namespace LocationTrackingAPI.Hubs
{
    public class LocationHub : Hub
    {
        private readonly ApplicationDbContext _context;
        
        public LocationHub(ApplicationDbContext context)
        {
            _context = context;
        }
        
        public async Task UpdateLocation(LocationUpdateDto locationUpdate)
        {
            var device = _context.DeviceLocations
                .FirstOrDefault(d => d.DeviceId == locationUpdate.DeviceId);
                
            if (device != null)
            {
                device.Latitude = locationUpdate.Latitude;
                device.Longitude = locationUpdate.Longitude;
                device.Altitude = locationUpdate.Altitude;
                device.Speed = locationUpdate.Speed;
                device.Accuracy = locationUpdate.Accuracy;
                device.Timestamp = DateTime.UtcNow;
                device.BatteryLevel = locationUpdate.BatteryLevel;
                device.IsOnline = true;
                
                _context.DeviceLocations.Update(device);
                await _context.SaveChangesAsync();
                
                await Clients.All.SendAsync("ReceiveLocationUpdate", device);
            }
        }
        
        public async Task RegisterDevice(DeviceRegistrationDto registration)
        {
            var existingDevice = _context.DeviceLocations
                .FirstOrDefault(d => d.DeviceId == registration.DeviceId);
                
            if (existingDevice == null)
            {
                var newDevice = new DeviceLocation
                {
                    DeviceId = registration.DeviceId,
                    DeviceName = registration.DeviceName,
                    Latitude = 0,
                    Longitude = 0,
                    Timestamp = DateTime.UtcNow
                };
                
                _context.DeviceLocations.Add(newDevice);
                await _context.SaveChangesAsync();
                
                await Clients.All.SendAsync("DeviceRegistered", newDevice);
            }
            else
            {
                existingDevice.IsOnline = true;
                existingDevice.DeviceName = registration.DeviceName;
                _context.Update(existingDevice);
                await _context.SaveChangesAsync();
                
                await Clients.All.SendAsync("DeviceOnline", existingDevice);
            }
            
            await Groups.AddToGroupAsync(Context.ConnectionId, registration.DeviceId);
        }
        
        public override async Task OnDisconnectedAsync(Exception exception)
        {
            await base.OnDisconnectedAsync(exception);
        }
    }
}
