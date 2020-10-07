import {Component, OnInit, ViewChild} from '@angular/core';
import { WsService} from '../../services';
import { FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import {Subject} from "rxjs";
import {DataTableDirective} from "angular-datatables";
import Swal from 'sweetalert2';

@Component({
  selector: 'app-tablas',
  templateUrl: './punto-venta.component.html',
  styleUrls: ['./punto-venta.component.scss']
})
export class PuntoVentaComponent implements OnInit {
  userTable: FormGroup;
  userTable2: FormGroup;
  control: FormArray;
  mode: boolean;
  touchedRows: any;
  public formventa: FormGroup;
  public formcantidad: FormGroup;
  public datos: any;
  public  id  = '';
  public  nombre = '';
  public  cantidad = 1;
  public  precio = 0;
  public stock = '';
  public totales = 0 ;

  constructor(private formBuilder: FormBuilder, public ws: WsService, private fb: FormBuilder) {
   // @ViewChild(DataTableDirective, {static: false}) dtElement: DataTableDirective;
    this.formulario();
    this.formularioCantidad();
  }

  ngOnInit() {
    this.touchedRows = [];
    this.userTable = this.fb.group({
      tableRows: this.fb.array([]), totales : [0]
    });
     // this.addRow();
  }

  ngAfterOnInit() {
    this.control = this.userTable.get('tableRows') as FormArray;
  }
  formulario(){
    this.formventa = this.formBuilder.group({
      imagen: ['', Validators.required],
      nombre: [ '', Validators.required],
      descripcion: [ '', Validators.required],
      precio: ['', Validators.required],
      stock: [ '', Validators.required],
      stock_minimo: ['', Validators.required],
      codigo_barras: ['']
    });
  }

  formularioCantidad(){
    this.formcantidad = this.formBuilder.group({
      cantidad: [this.cantidad, Validators.required],
    });
  }
  get codigo_barras(){
    return this.formventa.get('codigo_barras');
  }
  initiateForm(): FormGroup {
    // let totales;
    let total = this.precio * this.cantidad;
    const control =  this.userTable.get('totales').value;
    let totales = control + total ;
    this.totales = totales;
    this.userTable.get('totales').setValue(totales) ;
    console.log(totales) ;
    return this.fb.group({
      codigo: [this.id],
      nombre: [this.nombre],
      stock: [this.stock],
      cantidad: [this.cantidad],
      precio: [this.precio],
      total: [total],
      isEditable: [true]
    });
  }

  addRow() {
    const provider = this.formcantidad.value;
    this.cantidad = provider['cantidad'];
    const control =  this.userTable.get('tableRows') as FormArray;
    control.push(this.initiateForm());
  }

  deleteRow(index: number, total) {
    const control =  this.userTable.get('tableRows') as FormArray;
    const control2 =  this.userTable.get('totales').value;
    let totales = control2 - total ;
    this.totales = totales;
    this.userTable.get('totales').setValue(totales) ;
    console.log(totales) ;
    control.removeAt(index);
  }
  postVenta(){
    // const control = this.userTable.get('tableRows');
    const provider = this.userTable.value;
    // console.log(this.formLogin.value.usuario);
    console.log(provider);
    this.ws.WS_postVenta(provider).subscribe(data => {
      console.log(data);
      if ( data === 0){
        Swal.fire('Exito', 'Venta procesada correctamente', 'success');
      }else{
        Swal.fire('Error', 'Ocurrio un error al procesar la venta', 'error');
      }
      //    //this.resetForm();
   //  }else if (data['status'] === false){
   //    Swal.fire("Error", "No puede haber productos duplicados!", "error",);
   //  }else{
   //    Swal.fire("Error", "Se ha presentado un error, intente de nuevo!", "error",);
   //  }
    });
  }

  editRow(group: FormGroup) {
    group.get('isEditable').setValue(true);
  }

  doneRow(group: FormGroup) {
    group.get('isEditable').setValue(false);
  }

  saveUserDetails() {
    console.log(this.userTable.value);
  }

  get getFormControls() {
    const control = this.userTable.get('tableRows') as FormArray;
    return control;
  }

  submitForm() {
    const control = this.userTable.get('tableRows') as FormArray;
    this.touchedRows = control.controls.filter(row => row.touched).map(row => row.value);
    console.log(this.touchedRows);
  }

  toggleTheme() {
    this.mode = !this.mode;
  }
  venta() {
    const provider = this.formventa.value;
    this.ws.WS_venta(provider).subscribe(data => {
      // const pr = JSON.stringify(data);
      // const pr = JSON.parse(JSON.stringify(data));3
      if (data !== 'ERROR') {
        const pr = data;
        this.id = data[0]['id'];
        this.nombre = data[0]['nombre'];
        this.precio = data[0]['precio'];
        this.stock = data[0]['stock'];


        console.log(pr);
      }
    });
  }

}
