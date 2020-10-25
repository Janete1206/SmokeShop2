import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {GananciasRoutingModule} from './ganancias-routing.module';
import {GananciasComponent} from './ganancias.component';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    GananciasComponent
  ],
  imports: [
    CommonModule,
    GananciasRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    FormsModule
  ],

})
export class GananciasModule {
}
