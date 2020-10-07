import {Component, OnInit, ViewChild} from '@angular/core';
import { WsService} from '../../services';
import {Subject} from "rxjs";
import {DataTableDirective} from "angular-datatables";
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import Swal from "sweetalert2";
import {HttpClient} from '@angular/common/http';
import {consoleTestResultHandler} from 'tslint/lib/test';

@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.scss']
})
export class ProductosComponent implements OnInit {
  public formRegistrar: FormGroup;
  dtOptions2: DataTables.Settings={};
  dtTrigger2: Subject<any> = new Subject();
  info: any;
  producto = {id: '', imagen: '', nombre: '', descripcion: '', precio: '', stock: '', stock_minimo: '', codigo_barras: ''};
  constructor(public ws: WsService, private formBuilder: FormBuilder, public router: Router, private httpClient: HttpClient) {
    // @ViewChild(DataTableDirective, {static: false}) dtElement: DataTableDirective;
    this.formulario();
  }

  ngOnInit(): void {
    this.dtOptions2 = {
      pageLength: 4,
      pagingType: 'full_numbers'
    }
    this.ws.WS_PRODUCTOS().subscribe(data => {
      this.info = data;
      console.log(data);
      this.dtTrigger2.next();
    });
  }
  ngOnDestroy(): void{
    this.dtTrigger2.unsubscribe();
  }
  formulario(){
    this.formRegistrar = this.formBuilder.group({
      imagen: ['', Validators.required],
      nombre: [ '', Validators.required],
      descripcion: [ '', Validators.required],
      precio: ['', Validators.required],
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
  get stock(){
    return this.formRegistrar.get('stock');
  }
  get stock_minimo(){
    return this.formRegistrar.get('stock_minimo');
  }
  get codigo_barras(){
    return this.formRegistrar.get('codigo_barras');
  }

  resetForm(){
    this.formRegistrar.reset();
    this.router.navigate(['/productos']);
  }
  /*ngAfterViewInit(): void{
    //this.dtTrigger.next();
    this.dtTrigger2.next();
  }*/
  select_product( id, imagen, nombre, descripcion, precio, stock, stockMinimo, codigoBarras){
    this.producto = {id: id.toString(), imagen: imagen.toString(), nombre: nombre.toString(), descripcion: descripcion.toString(),
      precio: precio.toString(), stock: stock.toString(), stock_minimo: stockMinimo.toString(),
      codigo_barras: codigoBarras.toString()};
    console.log(this.producto);
    }
    update_product(){
      const provider = this.producto;
      this.ws.WS_UPDATEPRODUCT(provider).subscribe(data => {
        console.log(data);
        if ( data['success'] === 1){
          Swal.fire("Producto editado!", "Los cambios han sido guardados", "success");
          location.reload();
        }else{
          Swal.fire("Error", "Se ha presentado un error, intente de nuevo!", "error",);
        }
      });
    }
    delete_product(id){
      console.log('eliminar' + id);
      const provider = {id: id.toString()};
      this.ws.WS_DELETEPRODUCT(provider).subscribe(data => {
        console.log(data);
        if ( data['status'] === true){
          Swal.fire("Producto eliminado!", "Se ha eliminado con exito", "success");
          this.resetForm();
        }else if (data['status'] === false){
          Swal.fire("Error", "No puede haber productos duplicados!", "error",);
        }else{
          Swal.fire("Error", "Se ha presentado un error, intente de nuevo!", "error",);
        }
    }, error => {
      });
    }
}
