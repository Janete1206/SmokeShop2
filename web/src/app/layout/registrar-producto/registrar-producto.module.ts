import {NgModule} from '@angular/core';
import {RegistrarProductoRoutingModule} from './registrar-routing.module';
import {RegistrarProductoComponent} from './registrar-producto.component';
import {ReactiveFormsModule} from '@angular/forms';
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    RegistrarProductoComponent
  ],
  imports: [
    RegistrarProductoRoutingModule,
    ReactiveFormsModule,
    CommonModule
  ]
})
export class RegistrarProductoModule {
}
