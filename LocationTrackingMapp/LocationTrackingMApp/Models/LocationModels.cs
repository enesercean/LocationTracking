using System;

namespace LocationTrackingMApp.Models
{
    public class LocationUpdateDto
    {
        public string DeviceId { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public double? Altitude { get; set; }
        public double? Speed { get; set; }
        public double? Accuracy { get; set; }
        public string? BatteryLevel { get; set; }
    }
    
    public class DeviceRegistrationDto
    {
        public string DeviceId { get; set; }
        public string DeviceName { get; set; }
    }
}
