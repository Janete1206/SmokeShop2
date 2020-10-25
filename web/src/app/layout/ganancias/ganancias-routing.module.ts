import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GananciasComponent} from "./ganancias.component";


const routes: Routes = [
  {
    path: '', component: GananciasComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GananciasRoutingModule { }
