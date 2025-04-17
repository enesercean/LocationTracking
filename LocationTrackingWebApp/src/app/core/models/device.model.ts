export interface Device {
  id?: number;
  deviceId: string;
  deviceName: string;
  latitude: number;
  longitude: number;
  altitude?: number;
  speed?: number;
  accuracy?: number;
  timestamp: Date;
  isOnline: boolean;
  batteryLevel?: string;
}

export interface LocationUpdate {
  deviceId: string;
  latitude: number;
  longitude: number;
  altitude?: number;
  speed?: number;
  accuracy?: number;
  batteryLevel?: string;
}

export interface DeviceRegistration {
  deviceId: string;
  deviceName: string;
}
