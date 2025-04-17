namespace LocationTrackingMApp.Constants
{
    public static class AppSettings
    {
        // Replace with your actual server URL
        public const string ApiBaseUrl = "http://localhost:5266";
        
        // Location service settings
        public const int LocationUpdateIntervalSeconds = 10;
        public const int LocationTimeoutSeconds = 15;
        public const int LocationRetryDelaySeconds = 5;
        public const int MaxLocationRetries = 3;
    }
}
