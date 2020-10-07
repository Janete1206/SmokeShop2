import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductosAgotarComponent } from './productos-agotar.component';

describe('ProductosAgotarComponent', () => {
  let component: ProductosAgotarComponent;
  let fixture: ComponentFixture<ProductosAgotarComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProductosAgotarComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProductosAgotarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
