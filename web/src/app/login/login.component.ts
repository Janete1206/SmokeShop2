import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import { WsService} from '../services';
//import swal from 'sweetalert'
import Swal from 'sweetalert2'

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})



export class LoginComponent implements OnInit {
  Swal: 'sweetalert2';

  public formLogin: FormGroup;
  constructor(private formBuilder: FormBuilder, public ws: WsService, public router: Router) {
    this.formulario();

  }


  ngOnInit(): void {
  }

  formulario(){
    this.formLogin = this.formBuilder.group({
      email: [ '', Validators.required],
      password: ['', Validators.required]
    });
  }
  get email(){
    return this.formLogin.get('email');
  }
  get password(){
    return this.formLogin.get('password');
  }

  login(){
    const provider = this.formLogin.value;
    // console.log(this.formLogin.value.usuario);
    //  console.log(provider);
    this.ws.WS_LOGIN(provider).subscribe(data => {
      console.log(data);
      if ( data['success'] === 1){
        localStorage.setItem('token', data['token']);
        localStorage.setItem('iniciado','true');
        localStorage.setItem('rol', data['rol']);
        localStorage.setItem('usuario', data['nombre']);
        console.log('Logeado');
        if ((localStorage.getItem('rol')) === 'vendedor'){
          this.router.navigate(['/dashboard']);
        }else{
          this.router.navigate(['/AP']);
        }
      }else{
        console.log('Error de Credenciales');
        Swal.fire("Error", "Usuario o contraseña no coinciden", "error",);
        //alert('Usuario o contraseña no coinciden, vuelve a intentar');
      }
    });
  }
  jalarid(email) {
    this.formLogin.value.email = email;
    localStorage.setItem('email', this.formLogin.value.email);
  }
}
