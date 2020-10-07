import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {LectorRoutingModule} from './lector-routing.module';
import {LectorComponent} from './lector.component';
import {DataTablesModule} from "angular-datatables";
import {ReactiveFormsModule} from "@angular/forms";
import {HeaderComponent} from "./components";

@NgModule({
  declarations: [
    LectorComponent,
    HeaderComponent
  ],
  imports: [
    CommonModule,
    LectorRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    ReactiveFormsModule
  ],

})
export class LectorModule {
}
