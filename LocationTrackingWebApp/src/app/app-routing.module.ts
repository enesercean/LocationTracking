import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { 
    path: 'devices',
    loadChildren: () => import('./devices/devices.module').then(m => m.DevicesModule) 
  },
  { 
    path: 'tracking',
    loadChildren: () => import('./tracking/tracking.module').then(m => m.TrackingModule) 
  },
  { path: '', redirectTo: '/tracking', pathMatch: 'full' },
  { path: '**', redirectTo: '/tracking' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
