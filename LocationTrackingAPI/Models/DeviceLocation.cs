using System;
using System.ComponentModel.DataAnnotations;

namespace LocationTrackingAPI.Models
{
    public class DeviceLocation
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string DeviceId { get; set; }

        [Required]
        public string DeviceName { get; set; }

        [Required]
        public double Latitude { get; set; }

        [Required]
        public double Longitude { get; set; }

        public double? Altitude { get; set; }

        public double? Speed { get; set; }

        public double? Accuracy { get; set; }

        public DateTime Timestamp { get; set; } = DateTime.UtcNow;

        public bool IsOnline { get; set; } = true;

        public string? BatteryLevel { get; set; }
    }
    
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
