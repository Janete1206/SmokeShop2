import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {GenerarRoutingModule} from './generar-routing.module';
import {GenerarComponent} from './generar.component';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    GenerarComponent
  ],
  imports: [
    CommonModule,
    GenerarRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    FormsModule
  ],

})
export class GenerarModule {
}
