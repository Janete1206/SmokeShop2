import { CommonModule } from '@angular/common';
import {NgModule} from '@angular/core';
import {LayoutRoutingModule} from './layout-routing.module';
import {LayoutComponent} from './layout.component';
import {ReactiveFormsModule} from "@angular/forms";
import {HeaderComponent} from './components';
import {SidebarComponent} from './components';


@NgModule({
  declarations: [
    LayoutComponent,  HeaderComponent, SidebarComponent
  ],
  imports: [
    CommonModule,
    LayoutRoutingModule,
    ReactiveFormsModule
  ]
})
export class LayoutModule {
}
