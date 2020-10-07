import { Component, OnInit } from '@angular/core';
import { Router} from "@angular/router";
import {FormBuilder, FormGroup, Validator, Validators} from "@angular/forms";
import { WsService} from "../services";
import Swal from 'sweetalert2';

@Component({
  selector: 'app-login',
  templateUrl: './password_recovery.component.html',
  styleUrls: ['./password_recovery.component.scss']
})
export class Password_recoveryComponent implements OnInit {
  Swal: 'sweetalert2';
  public formLogin: FormGroup;
  constructor(private formBuilder: FormBuilder, public ws: WsService, public router: Router) {
    this.formulario();
  }

  ngOnInit(): void {
  }

  formulario(){
    this.formLogin = this.formBuilder.group({
      email:['', Validators.required]
    })
  }

  recuperar(){
    const provider = this.formLogin.value;
    // console.log(this.formLogin.value.usuario);
    console.log(provider);
    this.ws.WS_PASSWORD(provider).subscribe(data => {
      console.log(data);
      if (data['success'] === 1){
        Swal.fire('Contraseña recuperada', 'Revisa tu correo para obtener tu nueva contraseña', 'success');
        /*localStorage.setItem('token',data['token']);
        localStorage.setItem('rbac',data['rbac']);
        localStorage.setItem('iniciado','true');
        console.log("Logeado");
        this.router.navigate(['/dashboard']);*/
      }else{
        // console.log("Error de Credenciales");
        Swal.fire('Error', 'Este usuario no existe', 'error');
      }
    });

  }

}
