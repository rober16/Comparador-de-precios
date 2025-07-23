import { Routes } from '@angular/router';
import { HomeComponent } from './main/pages/home/home.component';
import { SucursalesComponent } from './main/pages/sucursales/sucursales/sucursales.component';

export const routes: Routes = [
  { path: 'inicio', component: HomeComponent },
  { path: 'inicio/sucursales', component: SucursalesComponent },
  { path: '**', redirectTo: 'inicio' }
];