import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {ProductosRoutingModule} from './productos-routing.module';
import {ProductosComponent} from './productos.component';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    ProductosComponent
  ],
  imports: [
    CommonModule,
    ProductosRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    FormsModule
  ],

})
export class ProductosModule {
}
