import {NgModule} from '@angular/core';
import { CommonModule } from '@angular/common';
import {PerfilRoutingModule} from './perfil-routing.module';
import {PerfilComponent} from './perfil.component';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    PerfilComponent
  ],
  imports: [
    CommonModule,
    PerfilRoutingModule,
    ReactiveFormsModule,
    DataTablesModule,
    FormsModule
  ],

})
export class PerfilModule {
}
