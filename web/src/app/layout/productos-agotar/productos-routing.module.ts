import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProductosAgotarComponent} from "./productos-agotar.component";


const routes: Routes = [
  {
    path: '', component: ProductosAgotarComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProductosAgotarRoutingModule { }
