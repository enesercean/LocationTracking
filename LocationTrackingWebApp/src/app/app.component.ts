import { Component, OnInit, OnDestroy, inject, PLATFORM_ID } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { SignalrService } from './core/services/signalr.service';
import { Subscription } from 'rxjs';
import { environment } from '../environments/environment';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  template: `
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-3">
      <div class="container">
        <a class="navbar-brand" routerLink="/">Location Tracking</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" routerLink="/tracking" routerLinkActive="active">Tracking</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" routerLink="/devices" routerLinkActive="active">Devices</a>
            </li>
          </ul>
          <div class="ms-auto">
            <span *ngIf="isBrowser" class="badge" [class.bg-success]="isConnected" [class.bg-danger]="!isConnected">
              {{ isConnected ? 'Connected' : 'Disconnected' }}
            </span>
          </div>
        </div>
      </div>
    </nav>

    <div class="container">
      <div *ngIf="isBrowser && !isConnected" class="alert alert-warning alert-dismissible fade show" role="alert">
        <strong>Connection Error:</strong> Unable to connect to the server.
        Please ensure the API server is running at {{ apiUrl }}.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <router-outlet></router-outlet>
    </div>
  `,
  styles: [`
    .navbar {
      margin-bottom: 1rem;
    }
  `]
})
export class AppComponent implements OnInit, OnDestroy {
  isConnected = false;
  apiUrl = environment.apiUrl;
  private subscription: Subscription = new Subscription();
  private platformId = inject(PLATFORM_ID);
  
  isBrowser = isPlatformBrowser(this.platformId);

  constructor(private signalrService: SignalrService) {}

  ngOnInit(): void {
    if (this.isBrowser) {
      this.initializeConnection();
      
      this.subscription.add(
        this.signalrService.isConnected().subscribe(connected => {
          this.isConnected = connected;
        })
      );
    }
  }

  ngOnDestroy(): void {
    // Clean up subscriptions to prevent memory leaks
    this.subscription.unsubscribe();
  }

  private initializeConnection(): void {
    if (environment.debug) {
      console.log('Initializing SignalR connection with API URL:', environment.apiUrl);
    }
    
    // Ensure we're in browser environment
    if (this.isBrowser) {
      setTimeout(() => {
        this.signalrService.startConnection();
      }, 1000); // Short delay to ensure app is fully initialized
    }
  }
}
