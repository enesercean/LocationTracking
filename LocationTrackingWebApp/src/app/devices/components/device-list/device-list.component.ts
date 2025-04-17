import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

import { SignalrService } from '../../../core/services/signalr.service';
import { Device } from '../../../core/models/device.model';

@Component({
  selector: 'app-device-list',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Device List</h5>
        <button class="btn btn-sm btn-primary" (click)="refreshDevices()">
          <i class="bi bi-arrow-clockwise"></i> Refresh
        </button>
      </div>
      <div class="list-group list-group-flush">
        <button 
          *ngFor="let device of devices" 
          class="list-group-item list-group-item-action d-flex justify-content-between align-items-center"
          [class.active]="selectedDeviceId === device.deviceId"
          [class.list-group-item-danger]="!device.isOnline"
          (click)="selectDevice(device)">
          <div>
            <strong>{{ device.deviceName }}</strong>
            <small class="d-block text-muted">Last seen: {{ device.timestamp | date:'short' }}</small>
          </div>
          <div>
            <span class="badge" [class.bg-success]="device.isOnline" [class.bg-danger]="!device.isOnline">
              {{ device.isOnline ? 'Online' : 'Offline' }}
            </span>
            <small class="d-block text-end" *ngIf="device.batteryLevel">
              <i class="bi bi-battery"></i> {{ device.batteryLevel }}
            </small>
          </div>
        </button>
        <div *ngIf="devices.length === 0" class="list-group-item text-center py-3">
          No devices found
        </div>
      </div>
    </div>
  `,
  styles: [`
    .list-group-item {
      cursor: pointer;
    }
  `]
})
export class DeviceListComponent implements OnInit, OnDestroy {
  devices: Device[] = [];
  selectedDeviceId: string | null = null;
  private destroy$ = new Subject<void>();

  constructor(
    private signalrService: SignalrService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.loadDevices();
    this.listenForUpdates();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  refreshDevices(): void {
    this.loadDevices();
  }

  private loadDevices(): void {
    this.signalrService.getDevices()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (devices) => {
          this.devices = devices;
        },
        error: (error) => {
          console.error('Error loading devices:', error);
        }
      });
  }

  private listenForUpdates(): void {
    this.signalrService.locationUpdate
      .pipe(takeUntil(this.destroy$))
      .subscribe(updatedDevice => {
        const index = this.devices.findIndex(d => d.deviceId === updatedDevice.deviceId);
        if (index !== -1) {
          this.devices[index] = updatedDevice;
        }
      });

    this.signalrService.deviceRegistered
      .pipe(takeUntil(this.destroy$))
      .subscribe(newDevice => {
        const index = this.devices.findIndex(d => d.deviceId === newDevice.deviceId);
        if (index !== -1) {
          this.devices[index] = newDevice;
        } else {
          this.devices.push(newDevice);
        }
      });

    this.signalrService.deviceRemoved
      .pipe(takeUntil(this.destroy$))
      .subscribe(deviceId => {
        this.devices = this.devices.filter(d => d.deviceId !== deviceId);
        if (this.selectedDeviceId === deviceId) {
          this.selectedDeviceId = null;
        }
      });

    this.signalrService.deviceOnline
      .pipe(takeUntil(this.destroy$))
      .subscribe(device => {
        const index = this.devices.findIndex(d => d.deviceId === device.deviceId);
        if (index !== -1) {
          this.devices[index] = device;
        }
      });
  }

  selectDevice(device: Device): void {
    this.selectedDeviceId = device.deviceId;
    this.router.navigate(['/tracking', device.deviceId]);
  }
}
