import {NgModule} from '@angular/core';
import {Password_recoveryRoutingModule} from './password_recovery-routing.module';
import {Password_recoveryComponent} from './password_recovery.component';
import {ReactiveFormsModule} from "@angular/forms";

@NgModule({
  declarations: [
    Password_recoveryComponent
  ],
  imports: [
    Password_recoveryRoutingModule,
    ReactiveFormsModule
  ]
})
export class Password_recoveryModule {
}
