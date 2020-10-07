import {NgModule} from '@angular/core';
import {RegistrarRoutingModule} from './registrar-routing.module';
import {RegistrarComponent} from './registrar.component';
import {ReactiveFormsModule} from '@angular/forms';
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    RegistrarComponent
  ],
  imports: [
    RegistrarRoutingModule,
    ReactiveFormsModule,
    CommonModule
  ]
})
export class RegistrarModule {
}
