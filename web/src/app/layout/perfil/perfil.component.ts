import {Component, OnInit, ViewChild} from '@angular/core';
import { WsService} from '../../services';
import {Subject} from "rxjs";
import {DataTableDirective} from "angular-datatables";
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import Swal from "sweetalert2";
import {HttpClient} from '@angular/common/http';
import {consoleTestResultHandler} from 'tslint/lib/test';
import {confirmContra} from '../../shared/confirmacion';


@Component({
  selector: 'app-perfil',
  templateUrl: './perfil.component.html',
  styleUrls: ['./perfil.component.scss']
})
export class PerfilComponent implements OnInit {
  usuario = localStorage.getItem('email');
  public formRegistrar: FormGroup;
  producto = { nombre: ''};

  data: any;
  myForm: FormGroup;
  info: any;
  constructor( public ws: WsService, private formBuilder: FormBuilder, public router: Router, private httpClient: HttpClient,) {
    this.formulario();
    httpClient.post('http://localhost/smoke/api_usuario.php/?getPerfil', {ref: this.usuario}).subscribe(data => {
      this.data = data;
      console.log(this.data);
    }, error => {
      alert('error:' + error.message);
    });
  }

  ngOnInit(): void {
  }
  formulario(){
    this.myForm = this.formBuilder.group({
        password: ['', Validators.compose([Validators.required, Validators.minLength(8)])],
        passEqual: ['', Validators.compose([Validators.required])],
        email: [localStorage.getItem('email')]
    },
      {
        validators: confirmContra, } );
  }
  get password(){
    return this.myForm.get('password');
  }
  /*ngAfterViewInit(): void{
    //this.dtTrigger.next();
    this.dtTrigger2.next();
  }*/

  equals(): boolean  {
    return  this.myForm.hasError('Nocoinciden')  &&
      this.myForm.get('password').dirty &&
      this.myForm.get('passEqual').dirty;
  }



  Cambiar_pass(){
    const provider = this.myForm.value;
    this.ws.WS_UPDATE_PASSWORD(provider).subscribe(data => {
      console.log(data);
      if ( data['success'] === 1){
        Swal.fire("Cambio de contraseña ok!", "Los cambios han sido guardados", "success");
        location.reload();
      }else{
        Swal.fire("Error", "Se ha presentado un error, intente de nuevo!", "error",);
      }
    });
  }

}
