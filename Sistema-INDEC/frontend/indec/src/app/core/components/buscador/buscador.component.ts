import { Component } from '@angular/core';
import { ReactiveFormsModule, FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-buscador',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './buscador.component.html',
  styleUrl: './buscador.component.css',
})
export class BuscadorComponent {
  formulario = new FormGroup({
    producto: new FormControl<string>('', { nonNullable: true }),
  });

  enviar() {
    if (this.formulario.invalid) return;
    console.log(this.formulario.value);
  }
}
