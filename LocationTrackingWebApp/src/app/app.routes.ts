import { Routes } from '@angular/router';

export const routes: Routes = [
  { 
    path: 'devices',
    loadComponent: () => import('./devices/components/device-list/device-list.component').then(c => c.DeviceListComponent)
  },
  { 
    path: 'devices/:id',
    loadComponent: () => import('./devices/components/device-detail/device-detail.component').then(c => c.DeviceDetailComponent) 
  },
  { 
    path: 'tracking',
    loadComponent: () => import('./tracking/components/location-viewer/location-viewer.component').then(c => c.LocationViewerComponent)
  },
  { 
    path: 'tracking/:id',
    loadComponent: () => import('./tracking/components/location-viewer/location-viewer.component').then(c => c.LocationViewerComponent)
  },
  { path: '', redirectTo: '/tracking', pathMatch: 'full' },
  { path: '**', redirectTo: '/tracking' }
];
