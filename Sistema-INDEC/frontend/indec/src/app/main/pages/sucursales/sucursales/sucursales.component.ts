import { Component } from '@angular/core';
import { FiltroLocalidadComponent } from '../../../../core/components/filtro-localidad/filtro-localidad.component';
import { ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-sucursales',
  standalone: true,
  imports: [FiltroLocalidadComponent],
  templateUrl: './sucursales.component.html',
  styleUrl: './sucursales.component.css'
})
export class SucursalesComponent {

}
