import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FiltroLocalidadComponent } from './filtro-localidad.component';

describe('FiltroLocalidadComponent', () => {
  let component: FiltroLocalidadComponent;
  let fixture: ComponentFixture<FiltroLocalidadComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FiltroLocalidadComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FiltroLocalidadComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
