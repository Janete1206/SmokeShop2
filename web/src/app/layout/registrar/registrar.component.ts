import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import { WsService} from '../../services/index';
import Swal from 'sweetalert2'
@Component({
  selector: 'app-registrar',
  templateUrl: './registrar.component.html',
  styleUrls: ['./registrar.component.scss']
})
export class RegistrarComponent implements OnInit {
  Swal: 'sweetalert2';
  public formRegistrar: FormGroup;
  private emailPattern: any = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  constructor(private formBuilder: FormBuilder, public ws: WsService, public router: Router) {
    this.formulario();
  }

  ngOnInit(): void {
  }

  formulario(){
    this.formRegistrar = this.formBuilder.group({
      nombre: [ '', Validators.required],
      email: [ '', Validators.compose([Validators.required, Validators.pattern(this.emailPattern)])],
      password: ['', Validators.compose([Validators.required, Validators.minLength(8)])],
      rol: [ '', Validators.required],
    });
  }
  get nombre(){
    return this.formRegistrar.get('nombre');
  }
  get email(){
    return this.formRegistrar.get('email');
  }
  get password(){
    return this.formRegistrar.get('password');
  }
  get rol(){
    return this.formRegistrar.get('rol');
  }

  Registrar_usuario(){
    const provider = this.formRegistrar.value;
    // console.log(this.formLogin.value.usuario);
    //  console.log(provider);
    this.ws.WS_REGISTRO(provider).subscribe(data => {
      console.log(data);
      if ( data['success'] === 1){
        this.formRegistrar.reset();
        Swal.fire("Usuario registrado!", "Se ha registrado un nuevo usuario", "success");
      }else{
        Swal.fire("Error", "Se ha presentado un error al registrar, intente de nuevo!", "error",);
      }
    });
  }
}
