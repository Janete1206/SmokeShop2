import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import { WsService} from '../../services/index';
import Swal from 'sweetalert2'

@Component({
  selector: 'app-registrarproducto',
  templateUrl: './registrar-producto.component.html',
  styleUrls: ['./registrar-producto.component.scss']
})
export class RegistrarProductoComponent implements OnInit {
  Swal: 'sweetalert2';
  public formRegistrar: FormGroup;
  constructor(private formBuilder: FormBuilder, public ws: WsService, public router: Router) {
    this.formulario();
  }
  ngOnInit(): void {
  }

  formulario(){
    this.formRegistrar = this.formBuilder.group({
      imagen: ['', Validators.required],
      nombre: [ '', Validators.required],
      descripcion: [ '', Validators.required],
      precio: ['', Validators.required],
      precio_proveedor: ['', Validators.required],
      stock: [ '', Validators.required],
      stock_minimo: ['', Validators.required],
      codigo_barras: ['', Validators.required]
    });
  }
  get imagen(){
    return this.formRegistrar.get('imagen');
  }
  get nombre(){
    return this.formRegistrar.get('nombre');
  }
  get descripcion(){
    return this.formRegistrar.get('descripcion');
  }
  get precio(){
    return this.formRegistrar.get('precio');
  }
  get precio_proveedor(){
    return this.formRegistrar.get('precio_proveedor');
  }
  get stock(){
    return this.formRegistrar.get('stock');
  }
  get stock_minimo(){
    return this.formRegistrar.get('stock_minimo');
  }
  get codigo_barras(){
    return this.formRegistrar.get('codigo_barras');
  }
  // resetForm(){
  //  this.formRegistrar.reset();
  //  this.router.navigate(['/productos']);
  // }

  Agregar_producto(){
    this.formRegistrar.value.imagen = this.formRegistrar.value.imagen.replace('C:\\fakepath\\', '');
    const provider = this.formRegistrar.value;
    // console.log(this.formLogin.value.usuario);
    console.log(provider);
    this.ws.WS_AGREGARPRODUCTO(provider).subscribe(data => {
      console.log(data);
      if ( data['status'] === true){
        Swal.fire("Producto registrado!", "Se ha insertado un nuevo producto", "success");
        //this.resetForm();
      }else if (data['status'] === false){
        Swal.fire("Error", "No puede haber productos duplicados!", "error",);
      }else{
        Swal.fire("Error", "Se ha presentado un error, intente de nuevo!", "error",);
      }
    });
  }
}
