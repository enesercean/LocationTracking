import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import * as signalR from '@microsoft/signalr';
import { BehaviorSubject, Observable, Subject, of } from 'rxjs';
import { catchError, retry } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { Device, LocationUpdate } from '../models/device.model';
import { isPlatformBrowser } from '@angular/common';
import { PLATFORM_ID } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SignalrService {
  private hubConnection!: signalR.HubConnection;
  private apiUrl = environment.apiUrl;
  private connectionEstablished = new BehaviorSubject<boolean>(false);
  private platformId = inject(PLATFORM_ID);
  
  public locationUpdate = new Subject<Device>();
  public deviceRegistered = new Subject<Device>();
  public deviceRemoved = new Subject<string>();
  public deviceOnline = new Subject<Device>();

  constructor(private http: HttpClient) { }

  public startConnection(): void {
    if (!isPlatformBrowser(this.platformId)) {
      console.log('SignalR connection skipped in server-side rendering');
      return;
    }

    try {
      this.hubConnection = new signalR.HubConnectionBuilder()
        .withUrl(`${this.apiUrl}/locationHub`, {
          skipNegotiation: true,
          transport: signalR.HttpTransportType.WebSockets
        })
        .withAutomaticReconnect([0, 2000, 5000, 10000, 30000]) 
        .configureLogging(signalR.LogLevel.Information)
        .build();
      
      console.log('Attempting to connect to SignalR hub at:', `${this.apiUrl}/locationHub`);
      
      this.hubConnection
        .start()
        .then(() => {
          console.log('SignalR connection established');
          this.connectionEstablished.next(true);
          this.registerSignalRHandlers();
        })
        .catch((err: Error) => {
          console.error('Error while establishing SignalR connection:', err);
          this.connectionEstablished.next(false);
          setTimeout(() => this.startConnection(), 5000);
        });

      this.hubConnection.onclose((error?: Error) => {
        console.log('SignalR connection closed', error);
        this.connectionEstablished.next(false);
      });
      
      this.hubConnection.onreconnecting((error?: Error) => {
        console.log('SignalR attempting to reconnect', error);
        this.connectionEstablished.next(false);
      });
      
      this.hubConnection.onreconnected((connectionId?: string) => {
        console.log('SignalR reconnected with ID:', connectionId);
        this.connectionEstablished.next(true);
        this.registerSignalRHandlers();
      });
    } catch (err) {
      console.error('Error setting up SignalR connection:', err);
      this.connectionEstablished.next(false);
    }
  }

  public isConnected(): Observable<boolean> {
    return this.connectionEstablished.asObservable();
  }

  private registerSignalRHandlers(): void {
    this.hubConnection.on('ReceiveLocationUpdate', (device: Device) => {
      console.log('Received location update:', device);
      this.locationUpdate.next(device);
    });
    
    this.hubConnection.on('DeviceRegistered', (device: Device) => {
      console.log('Device registered:', device);
      this.deviceRegistered.next(device);
    });
    
    this.hubConnection.on('DeviceRemoved', (deviceId: string) => {
      console.log('Device removed:', deviceId);
      this.deviceRemoved.next(deviceId);
    });
    
    this.hubConnection.on('DeviceOnline', (device: Device) => {
      console.log('Device online status changed:', device);
      this.deviceOnline.next(device);
    });
  }

  public getDevices(): Observable<Device[]> {
    return this.http.get<Device[]>(`${this.apiUrl}/api/device`)
      .pipe(
        retry(2),
        catchError(error => {
          console.error('Error fetching devices:', error);
          return of([]);
        })
      );
  }

  public getDevice(deviceId: string): Observable<Device> {
    return this.http.get<Device>(`${this.apiUrl}/api/device/${deviceId}`)
      .pipe(
        retry(2),
        catchError(error => {
          console.error(`Error fetching device ${deviceId}:`, error);
          throw error;
        })
      );
  }

  public registerDevice(deviceId: string, deviceName: string): Observable<Device> {
    return this.http.post<Device>(`${this.apiUrl}/api/device/register`, { deviceId, deviceName })
      .pipe(
        catchError(error => {
          console.error('Error registering device:', error);
          throw error;
        })
      );
  }

  public updateLocation(update: LocationUpdate): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/api/device/update-location`, update)
      .pipe(
        catchError(error => {
          console.error('Error updating location:', error);
          throw error;
        })
      );
  }

  public deleteDevice(deviceId: string): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/api/device/${deviceId}`)
      .pipe(
        catchError(error => {
          console.error(`Error deleting device ${deviceId}:`, error);
          throw error;
        })
      );
  }
}
