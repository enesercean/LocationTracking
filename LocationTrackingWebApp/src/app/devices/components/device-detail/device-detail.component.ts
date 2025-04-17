import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

import { SignalrService } from '../../../core/services/signalr.service';
import { Device } from '../../../core/models/device.model';

@Component({
  selector: 'app-device-detail',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="card" *ngIf="device">
      <div class="card-header">
        <h5 class="mb-0">{{ device.deviceName }}</h5>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <strong>Status:</strong>
          <span class="badge ms-2" [class.bg-success]="device.isOnline" [class.bg-danger]="!device.isOnline">
            {{ device.isOnline ? 'Online' : 'Offline' }}
          </span>
        </div>
        <div class="mb-3">
          <strong>Device ID:</strong> {{ device.deviceId }}
        </div>
        <div class="mb-3">
          <strong>Last Updated:</strong> {{ device.timestamp | date:'medium' }}
        </div>
        <div class="mb-3">
          <strong>Battery:</strong> {{ device.batteryLevel || 'Unknown' }}
        </div>
        <div class="mb-3">
          <strong>Location:</strong><br>
          Latitude: {{ device.latitude | number:'1.6-6' }}<br>
          Longitude: {{ device.longitude | number:'1.6-6' }}
        </div>
        <div class="mb-3" *ngIf="device.altitude">
          <strong>Altitude:</strong> {{ device.altitude | number:'1.2-2' }} m
        </div>
        <div class="mb-3" *ngIf="device.speed">
          <strong>Speed:</strong> {{ device.speed | number:'1.2-2' }} km/h
        </div>
        <div class="mb-3" *ngIf="device.accuracy">
          <strong>Accuracy:</strong> {{ device.accuracy | number:'1.2-2' }} m
        </div>
      </div>
      <div class="card-footer">
        <button class="btn btn-danger" (click)="deleteDevice()">Delete Device</button>
      </div>
    </div>
  `
})
export class DeviceDetailComponent implements OnInit, OnDestroy {
  device: Device | null = null;
  private deviceId: string;
  private destroy$ = new Subject<void>();

  constructor(
    private route: ActivatedRoute,
    private signalrService: SignalrService
  ) {
    this.deviceId = this.route.snapshot.paramMap.get('id') || '';
  }

  ngOnInit(): void {
    if (this.deviceId) {
      this.loadDevice();
      this.listenForUpdates();
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  private loadDevice(): void {
    this.signalrService.getDevice(this.deviceId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (device) => {
          this.device = device;
        },
        error: (error) => {
          console.error('Error loading device details:', error);
        }
      });
  }

  private listenForUpdates(): void {
    this.signalrService.locationUpdate
      .pipe(takeUntil(this.destroy$))
      .subscribe(updatedDevice => {
        if (updatedDevice.deviceId === this.deviceId) {
          this.device = updatedDevice;
        }
      });

    this.signalrService.deviceRemoved
      .pipe(takeUntil(this.destroy$))
      .subscribe(deviceId => {
        if (deviceId === this.deviceId) {
          console.log('This device has been removed');
        }
      });
  }

  deleteDevice(): void {
    if (!this.device) return;
    
    if (confirm(`Are you sure you want to delete ${this.device.deviceName}?`)) {
      this.signalrService.deleteDevice(this.device.deviceId)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            console.log('Device deleted successfully');
          },
          error: (error) => {
            console.error('Error deleting device:', error);
          }
        });
    }
  }
}
