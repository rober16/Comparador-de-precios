import { Component, AfterViewInit, Inject, PLATFORM_ID } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import * as L from 'leaflet';

@Component({
  selector: 'app-mapa-sucursales',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './mapa-sucursales.component.html',
  styleUrl: './mapa-sucursales.component.css',
})
export class MapaSucursalesComponent implements AfterViewInit {
  isBrowser = false;
  private map: any;
  private L: any;

  constructor(@Inject(PLATFORM_ID) private platformId: Object) {
    this.isBrowser = isPlatformBrowser(this.platformId);
  }

  async ngAfterViewInit(): Promise<void> {
    if (!this.isBrowser) {
      return;
    }
    const { default: L } = await import('leaflet');
    this.L = L;

    const container = document.getElementById('map')!;
    this.map = this.L.map(container).setView([-31.41, -64.18], 13);

    this.L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors',
      maxZoom: 19
    }).addTo(this.map);

    this.L.marker([-31.41, -64.18]).addTo(this.map)
      .bindPopup('Aquí estoy')
      .openPopup();
  }
}
