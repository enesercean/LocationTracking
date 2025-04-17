using Microsoft.AspNetCore.Mvc;
using LocationTrackingAPI.Models;
using LocationTrackingAPI.Data;
using Microsoft.AspNetCore.SignalR;
using LocationTrackingAPI.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LocationTrackingAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DeviceController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHubContext<LocationHub> _hubContext;
        
        public DeviceController(ApplicationDbContext context, IHubContext<LocationHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }
        
        [HttpGet]
        public ActionResult<IEnumerable<DeviceLocation>> GetAllDevices()
        {
            return Ok(_context.DeviceLocations.ToList());
        }
        
        [HttpGet("{id}")]
        public ActionResult<DeviceLocation> GetDevice(string id)
        {
            var device = _context.DeviceLocations.FirstOrDefault(d => d.DeviceId == id);
            if (device == null)
            {
                return NotFound();
            }
            
            return Ok(device);
        }
        
        [HttpPost("register")]
        public async Task<ActionResult<DeviceLocation>> RegisterDevice(DeviceRegistrationDto registration)
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
                
                await _hubContext.Clients.All.SendAsync("DeviceRegistered", newDevice);
                
                return CreatedAtAction(nameof(GetDevice), new { id = newDevice.DeviceId }, newDevice);
            }
            
            existingDevice.DeviceName = registration.DeviceName;
            existingDevice.IsOnline = true;
            _context.Update(existingDevice);
            await _context.SaveChangesAsync();
            
            return Ok(existingDevice);
        }
        
        [HttpPost("update-location")]
        public async Task<ActionResult> UpdateLocation(LocationUpdateDto locationUpdate)
        {
            var device = _context.DeviceLocations
                .FirstOrDefault(d => d.DeviceId == locationUpdate.DeviceId);
                
            if (device == null)
            {
                return NotFound($"Device with ID {locationUpdate.DeviceId} not found");
            }
            
            device.Latitude = locationUpdate.Latitude;
            device.Longitude = locationUpdate.Longitude;
            device.Altitude = locationUpdate.Altitude;
            device.Speed = locationUpdate.Speed;
            device.Accuracy = locationUpdate.Accuracy;
            device.Timestamp = DateTime.UtcNow;
            device.BatteryLevel = locationUpdate.BatteryLevel;
            
            _context.DeviceLocations.Update(device);
            await _context.SaveChangesAsync();
            
            await _hubContext.Clients.All.SendAsync("ReceiveLocationUpdate", device);
            
            return Ok();
        }
        
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteDevice(string id)
        {
            var device = _context.DeviceLocations.FirstOrDefault(d => d.DeviceId == id);
            if (device == null)
            {
                return NotFound();
            }
            
            _context.DeviceLocations.Remove(device);
            await _context.SaveChangesAsync();
            
            await _hubContext.Clients.All.SendAsync("DeviceRemoved", id);
            
            return NoContent();
        }
    }
}
