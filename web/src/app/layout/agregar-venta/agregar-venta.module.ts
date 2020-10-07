import {NgModule} from '@angular/core';
import {AgregarVentaRoutingModule} from './agregar-venta-routing.module';
import {AgregarVentaComponent} from './agregar-venta.component';
import {ReactiveFormsModule} from '@angular/forms';
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    AgregarVentaComponent
  ],
  imports: [
    AgregarVentaRoutingModule,
    ReactiveFormsModule,
    CommonModule
  ]
})
export class AgregarVentaModule {
}
