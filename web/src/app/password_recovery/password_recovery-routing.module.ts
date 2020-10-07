import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Password_recoveryComponent} from "./password_recovery.component";


const routes: Routes = [
  {
    path: '', component: Password_recoveryComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class Password_recoveryRoutingModule { }
