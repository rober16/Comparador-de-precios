import { CommonModule } from '@angular/common';
import { Component, OnInit, SimpleChanges } from '@angular/core';
import { IProvincias } from '../../../main/api/models/i-provincias';
import { SucursalesService } from '../../../main/api/resources/sucursales.service';
import { ReactiveFormsModule, FormControl } from '@angular/forms';
import { ILocalidades } from '../../../main/api/models/i-localidades';

@Component({
  selector: 'app-filtro-localidad',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './filtro-localidad.component.html',
  styleUrl: './filtro-localidad.component.css'
})
export class FiltroLocalidadComponent implements OnInit {
  provincias: IProvincias[] = [];
  localidades: ILocalidades[] = [];
  
  provincia = new FormControl('0');
  localidad = new FormControl('0');

  constructor(private sucursalesServices: SucursalesService) {}
  
  ngOnInit(): void {
    this.sucursalesServices.obtenerProvincias().subscribe((data) => {
      this.provincias = data;
    });

    this.provincia.valueChanges.subscribe(codProvincia => {
      if (codProvincia && codProvincia !== '0') {
        this.sucursalesServices.obtenerLocalidadesXProvincia(codProvincia).subscribe((data) => {
          this.localidades = data;
        });
      }
    });
  }
}
