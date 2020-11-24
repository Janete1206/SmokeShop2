import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GenerarComponent} from "./generar.component";


const routes: Routes = [
  {
    path: '', component: GenerarComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GenerarRoutingModule { }
