import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { IProvincias } from '../../../main/api/models/i-provincias';
import { SucursalesService } from '../../../main/api/resources/sucursales.service';
import { ReactiveFormsModule, FormControl } from '@angular/forms';

@Component({
  selector: 'app-filtro-localidad',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './filtro-localidad.component.html',
  styleUrl: './filtro-localidad.component.css'
})
export class FiltroLocalidadComponent implements OnInit {
  provincias: IProvincias[] = [];
  provincia = new FormControl('');
  localidades = new FormControl('');

  constructor(private sucursalesServices: SucursalesService) {}

  ngOnInit(): void {
    this.sucursalesServices.obtenerProvincias().subscribe((data) => {
      this.provincias = data;
    });
  }
}
