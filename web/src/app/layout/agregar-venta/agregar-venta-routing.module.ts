import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AgregarVentaComponent} from './agregar-venta.component';


const routes: Routes = [
  {
    path: '', component: AgregarVentaComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AgregarVentaRoutingModule { }
