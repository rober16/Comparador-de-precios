import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { IProvincias } from '../models/i-provincias';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SucursalesService {
  private apiUrl = 'http://localhost:8085/api/v1/indec/provincias';
  constructor(private http: HttpClient) {}

  private getAuthHeaders(): HttpHeaders {
    // Credenciales de usuario
    const username = 'usr_admin';
    const password = 'pwd_admin';

    // Codificación en Base64 para el encabezado Authorization
    const auth = 'Basic ' + btoa(`${username}:${password}`);

    // Retorna encabezados con autorización básica
    return new HttpHeaders({
      Authorization: auth,
    });
  }

  obtenerProvincias(): Observable<IProvincias[]> {
    return this.http.get<IProvincias[]>(this.apiUrl,{
      headers: this.getAuthHeaders(),
      withCredentials: true
    });
  }
}
