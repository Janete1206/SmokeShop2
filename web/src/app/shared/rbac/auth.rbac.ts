import { Injectable } from "@angular/core";
import { CanActivate, Router} from "@angular/router";
import {WsService} from "../../services";

@Injectable({
  providedIn: 'root'
})
export  class AuthRbac implements CanActivate{
  rol: boolean = false;
  constructor(public ws: WsService, private router:Router) {
  }

  canActivate(){
    this.ws.WS_RBAC({'rol':'administrador','token':localStorage.getItem('token')}).subscribe(data =>{
      console.log(data);
      if(data['success']===1){
        this.rol = true;
      }else{
        this.router.navigate(['/']);
        this.rol= false;
      }
    });
    return this.rol;
  }

}
