import { Component, OnInit, OnDestroy, AfterViewInit, Input, inject, PLATFORM_ID } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

import { SignalrService } from '../../../core/services/signalr.service';
import { Device } from '../../../core/models/device.model';
import { loadLeaflet } from '../../../core/utils/platform-utils';

interface LeafletStatic {
  map: (id: string, options?: any) => Map;
  tileLayer: (template: string, options?: any) => TileLayer;
  latLng: (lat: number, lng: number) => LatLng;
  marker: (latlng: LatLng, options?: any) => Marker;
}

interface Map {
  setView: (center: LatLng | [number, number], zoom: number) => Map;
  removeLayer: (layer: any) => Map;
}

interface TileLayer {
  addTo: (map: Map) => TileLayer;
}

interface LatLng {
  lat: number;
  lng: number;
}

interface Marker {
  setLatLng: (latlng: LatLng) => Marker;
  bindPopup: (content: string) => Marker;
  addTo: (map: Map) => Marker;
  openPopup: () => Marker;
}

@Component({
  selector: 'app-map',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="card">
      <div class="card-header">
        <h5 class="mb-0">Location Tracker</h5>
      </div>
      <div class="card-body p-0">
        <div id="map" class="map-container" *ngIf="isBrowser"></div>
        <div *ngIf="!isBrowser" class="map-placeholder text-center p-5 bg-light">
          <p>Map will be available after page loads</p>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .map-container {
      height: 500px;
      width: 100%;
    }
    .map-placeholder {
      height: 500px;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
    }
  `]
})
export class MapComponent implements OnInit, OnDestroy, AfterViewInit {
  @Input() deviceId: string | null = null;
  
  private map: Map | null = null;
  private L: LeafletStatic | null = null;
  private markers: { [deviceId: string]: Marker } = {};
  private devices: Device[] = [];
  private destroy$ = new Subject<void>();
  private selectedDevice: Device | null = null;
  private platformId = inject(PLATFORM_ID);

  isBrowser = isPlatformBrowser(this.platformId);

  constructor(
    private route: ActivatedRoute,
    private signalrService: SignalrService
  ) { }

  ngOnInit(): void {
    this.route.paramMap
      .pipe(takeUntil(this.destroy$))
      .subscribe(params => {
        const id = params.get('id');
        if (id) {
          this.deviceId = id;
          this.loadDevice(id);
        }
      });

    this.loadAllDevices();
    this.listenForUpdates();
  }

  ngAfterViewInit(): void {
    if (this.isBrowser) {
      this.loadLeafletAndInitMap();
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  private async loadLeafletAndInitMap(): Promise<void> {
    try {
      this.L = await loadLeaflet();
      setTimeout(() => this.initMap(), 100);
    } catch (error) {
      console.error('Failed to load Leaflet:', error);
    }
  }

  private initMap(): void {
    if (!this.isBrowser || !this.L) {
      return;
    }
    
    this.map = this.L.map('map').setView([39.9334, 32.8597], 10);
    
    this.L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
    }).addTo(this.map);

    this.devices.forEach(device => {
      this.addOrUpdateMarker(device);
    });
  }

  private loadDevice(deviceId: string): void {
    this.signalrService.getDevice(deviceId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (device) => {
          this.selectedDevice = device;
          if (this.isBrowser && this.map && this.L) {
            this.addOrUpdateMarker(device);
            this.centerMapOnDevice(device);
          }
        },
        error: (error) => {
          console.error('Error loading device:', error);
        }
      });
  }

  private loadAllDevices(): void {
    this.signalrService.getDevices()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (devices) => {
          this.devices = devices;
          
          if (this.isBrowser && this.map && this.L) {
            devices.forEach(device => {
              this.addOrUpdateMarker(device);
            });
          }
        },
        error: (error) => {
          console.error('Error loading devices:', error);
        }
      });
  }

  private listenForUpdates(): void {
    this.signalrService.locationUpdate
      .pipe(takeUntil(this.destroy$))
      .subscribe(device => {
        const index = this.devices.findIndex(d => d.deviceId === device.deviceId);
        if (index !== -1) {
          this.devices[index] = device;
        } else {
          this.devices.push(device);
        }
        
        if (this.isBrowser && this.map && this.L) {
          this.addOrUpdateMarker(device);
          
          if (this.deviceId === device.deviceId) {
            this.selectedDevice = device;
            this.centerMapOnDevice(device);
          }
        }
      });
    
    this.signalrService.deviceRemoved
      .pipe(takeUntil(this.destroy$))
      .subscribe(deviceId => {
        this.devices = this.devices.filter(d => d.deviceId !== deviceId);
        
        if (this.isBrowser && this.markers[deviceId] && this.map) {
          this.map.removeLayer(this.markers[deviceId]);
          delete this.markers[deviceId];
        }
      });
  }

  private addOrUpdateMarker(device: Device): void {
    if (!this.isBrowser || !this.map || !this.L || !device.latitude || !device.longitude) {
      return;
    }
    
    const position = this.L.latLng(device.latitude, device.longitude);
    
    if (this.markers[device.deviceId]) {
      this.markers[device.deviceId].setLatLng(position);
      this.updatePopupContent(this.markers[device.deviceId], device);
    } else {
      const marker = this.L.marker(position, {
        title: device.deviceName
      }).addTo(this.map);
      
      this.updatePopupContent(marker, device);
      this.markers[device.deviceId] = marker;
    }
  }

  private updatePopupContent(marker: Marker, device: Device): void {
    const popupContent = `
      <div>
        <h5>${device.deviceName}</h5>
        <p>
          <strong>Status:</strong> ${device.isOnline ? 'Online' : 'Offline'}<br>
          <strong>Last updated:</strong> ${new Date(device.timestamp).toLocaleString()}<br>
          ${device.batteryLevel ? `<strong>Battery:</strong> ${device.batteryLevel}<br>` : ''}
          ${device.speed ? `<strong>Speed:</strong> ${device.speed.toFixed(2)} km/h<br>` : ''}
        </p>
      </div>
    `;
    
    marker.bindPopup(popupContent);
    
    if (device.deviceId === this.deviceId) {
      marker.openPopup();
    }
  }

  private centerMapOnDevice(device: Device): void {
    if (this.isBrowser && this.map && this.L && device.latitude && device.longitude) {
      this.map.setView([device.latitude, device.longitude], 15);
      
      if (this.markers[device.deviceId]) {
        this.markers[device.deviceId].openPopup();
      }
    }
  }
}
