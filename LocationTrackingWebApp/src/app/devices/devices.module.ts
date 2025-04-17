import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';

import { DeviceListComponent } from './components/device-list/device-list.component';
import { DeviceDetailComponent } from './components/device-detail/device-detail.component';

const routes: Routes = [
  { path: '', component: DeviceListComponent },
  { path: ':id', component: DeviceDetailComponent }
];

@NgModule({
  declarations: [
    DeviceListComponent,
    DeviceDetailComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes)
  ],
  exports: [
    DeviceListComponent,
    DeviceDetailComponent
  ]
})
export class DevicesModule { }
