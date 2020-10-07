import {NgModule} from '@angular/core';
import {LoginRoutingModule} from './login-routing.module';
import {LoginComponent} from './login.component';
import {ReactiveFormsModule} from "@angular/forms";
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    LoginComponent
  ],
  imports: [
    LoginRoutingModule,
    ReactiveFormsModule,
    CommonModule
  ]
})
export class LoginModule {
}
