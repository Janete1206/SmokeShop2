import { Component, OnInit } from '@angular/core';
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import { WsService} from '../../services/index';
import Swal from 'sweetalert2';
import {isNumber} from 'util';

@Component({
  selector: 'app-registrarproducto',
  templateUrl: './agregar-venta.component.html',
  styleUrls: ['./agregar-venta.component.scss']
})
export class AgregarVentaComponent implements OnInit {
  Swal: 'sweetalert2';
  info: any;
  producto = {id: '', imagen: '', nombre: '', descripcion: '', precio: '', stock: '', stock_minimo: '', codigo_barras: ''};
  public formventa: FormGroup;
  constructor(private formBuilder: FormBuilder, public ws: WsService, public router: Router) {
    this.formulario();
  }
  ngOnInit(): void {
  }

  formulario(){
    this.formventa = this.formBuilder.group({
      imagen: ['', Validators.required],
      nombre: [ '', Validators.required],
      descripcion: [ '', Validators.required],
      precio: ['', Validators.required],
      stock: [ '', Validators.required],
      cantidad: ['', Validators.required],
      total: ['', Validators.required],
      codigo_barras: ['', Validators.required]
    });
  }
  get imagen(){
    return this.formventa.get('imagen');
  }
  get nombre(){
    return this.formventa.get('nombre');
  }
  get descripcion(){
    return this.formventa.get('descripcion');
  }
  get precio(){
    return this.formventa.get('precio');
  }
  get stock(){
    return this.formventa.get('stock');
  }
  get stock_minimo(){
    return this.formventa.get('stock_minimo');
  }
  get codigo_barras(){
    return this.formventa.get('codigo_barras');
  }
  resetForm(){
    this.formventa.reset();
    this.router.navigate(['/productos']);
  }
  enviar(){
    const b: any = $('#txt_precio').html();
    // console.log(this.formLogin.value.usuario);
    //  console.log(provider);
    this.ws.WS_add_detalle(b).subscribe(data => {
      console.log(data);
    });
  }
  total(){
    const a: any  = document.getElementById('txt_cant_producto') ;
    const b: any = $('#txt_precio').html();
    const current = a.value;
    console.log(b);
    const x: any = current * b;
    console.log(current);
    console.log(x);
    $('#txt_total').html(x);
  }

  venta() {
    const provider = this.formventa.value;
    this.ws.WS_venta(provider).subscribe(data => {
       // const pr = JSON.stringify(data);
       // const pr = JSON.parse(JSON.stringify(data));3
      if (data !== 'ERROR') {
        const pr = data;
        console.log(pr);
        $('#txt_nombre').html(pr[0].nombre);
        $('#txt_stock').html(pr[0].stock);
        $('#txt_precio').html(pr[0].precio);
        $('#txt_total').html(pr[0].precio);
        $('#txt_cant_producto').removeAttr('disabled');
      }else{
        $('#txt_nombre').html('-');
        $('#txt_stock').html('-');
        $('#txt_precio').html('0.00');
        $('#txt_total').html('0.00');
        $('#txt_cant_producto').removeAttr('0');

      }
    });
  }
}
