import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {ProductosAgotarRoutingModule} from './productos-routing.module';
import {ProductosAgotarComponent} from './productos-agotar.component';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';



@NgModule({
  declarations: [
    ProductosAgotarComponent
  ],
  imports: [
    CommonModule,
    ProductosAgotarRoutingModule,
    ReactiveFormsModule,
    DataTablesModule
  ],

})
export class ProductosAgotarModule {
}
