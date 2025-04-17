import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';

import { DevicesModule } from '../devices/devices.module';
import { MapComponent } from './components/map/map.component';
import { LocationViewerComponent } from './components/location-viewer/location-viewer.component';

const routes: Routes = [
  { path: '', component: LocationViewerComponent },
  { path: ':id', component: LocationViewerComponent }
];

@NgModule({
  declarations: [
    MapComponent,
    LocationViewerComponent
  ],
  imports: [
    CommonModule,
    DevicesModule,
    RouterModule.forChild(routes)
  ]
})
export class TrackingModule { }
