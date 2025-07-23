import { Component } from '@angular/core';
import { HeaderComponent } from '../../../core/components/header/header.component';
import { BuscadorComponent } from '../../../core/components/buscador/buscador.component';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterOutlet, HeaderComponent, BuscadorComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})

export class HomeComponent {

}
