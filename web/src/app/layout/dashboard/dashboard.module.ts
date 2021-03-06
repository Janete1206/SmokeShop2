import {NgModule} from '@angular/core';
import {DashboardRoutingModule} from './dashboard-routing.module';
import {DashboardComponent} from './dashboard.component';
import {ReactiveFormsModule} from "@angular/forms";

@NgModule({
  declarations: [
    DashboardComponent, 
  ],
  imports: [
    DashboardRoutingModule,
    ReactiveFormsModule
  ]
})
export class DashboardModule {
}
