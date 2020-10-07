import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {PuntoVentaRoutingModule} from './punto-venta-routing.module';
import {PuntoVentaComponent} from './punto-venta.component';
import {DataTablesModule} from "angular-datatables";
import {ReactiveFormsModule} from "@angular/forms";
import {HeaderComponent} from "./components";

@NgModule({
  declarations: [
    PuntoVentaComponent,
    HeaderComponent
  ],
  imports: [
    CommonModule,
    PuntoVentaRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    ReactiveFormsModule
  ],

})
export class PuntoVentaModule {
}
