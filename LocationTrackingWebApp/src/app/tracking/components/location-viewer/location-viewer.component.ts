import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

import { SignalrService } from '../../../core/services/signalr.service';
import { Device } from '../../../core/models/device.model';
import { DeviceListComponent } from '../../../devices/components/device-list/device-list.component';
import { DeviceDetailComponent } from '../../../devices/components/device-detail/device-detail.component';
import { MapComponent } from '../map/map.component';

@Component({
  selector: 'app-location-viewer',
  standalone: true,
  imports: [
    CommonModule, 
    DeviceListComponent, 
    DeviceDetailComponent, 
    MapComponent
  ],
  template: `
    <div class="row">
      <div class="col-md-4">
        <app-device-list></app-device-list>
      </div>
      <div class="col-md-8">
        <app-map [deviceId]="deviceId"></app-map>
        <div class="mt-3" *ngIf="selectedDevice">
          <app-device-detail></app-device-detail>
        </div>
      </div>
    </div>
  `
})
export class LocationViewerComponent implements OnInit, OnDestroy {
  deviceId: string | null = null;
  selectedDevice: Device | null = null;
  private destroy$ = new Subject<void>();

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
    
    this.listenForUpdates();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  private loadDevice(deviceId: string): void {
    this.signalrService.getDevice(deviceId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (device) => {
          this.selectedDevice = device;
        },
        error: (error) => {
          console.error('Error loading device:', error);
        }
      });
  }

  private listenForUpdates(): void {
    this.signalrService.locationUpdate
      .pipe(takeUntil(this.destroy$))
      .subscribe(device => {
        if (this.deviceId && device.deviceId === this.deviceId) {
          this.selectedDevice = device;
        }
      });
    
    this.signalrService.deviceRemoved
      .pipe(takeUntil(this.destroy$))
      .subscribe(deviceId => {
        if (deviceId === this.deviceId) {
          this.selectedDevice = null;
        }
      });
  }
}
