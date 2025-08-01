import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MapaSucursalesComponent } from './mapa-sucursales.component';

describe('MapaSucursalesComponent', () => {
  let component: MapaSucursalesComponent;
  let fixture: ComponentFixture<MapaSucursalesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MapaSucursalesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MapaSucursalesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
