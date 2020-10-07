import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {ReportesRoutingModule} from './reportes-routing.module';
import {ReportesComponent} from './reportes.component';
import {ReactiveFormsModule} from "@angular/forms";
// import {HeaderComponent} from "./components/header/header.component";
import { ChartModule, HIGHCHARTS_MODULES } from "angular-highcharts";
import more from 'highcharts/highcharts-more.src';
import {DataTablesModule} from "angular-datatables";

export function highchrtsModules() {
  return [more];
}

@NgModule({
  declarations: [
    ReportesComponent
  ],
  imports: [
    CommonModule,
    ReportesRoutingModule,
    ReactiveFormsModule,
    ChartModule,
    DataTablesModule
  ],
  providers: [
    { provide: HIGHCHARTS_MODULES, useFactory: highchrtsModules }
  ]
})
export class ReportesModule {
}
