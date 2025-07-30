import { Component } from '@angular/core';
import { FiltroLocalidadComponent } from '../../../../core/components/filtro-localidad/filtro-localidad.component';
import { ReactiveFormsModule } from '@angular/forms';
import { ISucursales } from '../../../api/models/i-sucursales';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-sucursales',
  standalone: true,
  imports: [FiltroLocalidadComponent, CommonModule],
  templateUrl: './sucursales.component.html',
  styleUrl: './sucursales.component.css'
})
export class SucursalesComponent {
  sucursales: ISucursales[] = [];

  procesarSucursales(event: ISucursales[]) {
    this.sucursales = event;
  }
}
