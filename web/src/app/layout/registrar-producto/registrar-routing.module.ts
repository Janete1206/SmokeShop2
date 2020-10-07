import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RegistrarProductoComponent} from './registrar-producto.component';


const routes: Routes = [
  {
    path: '', component: RegistrarProductoComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RegistrarProductoRoutingModule { }
