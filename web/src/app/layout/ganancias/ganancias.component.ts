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
  selector: 'app-ganancias',
  templateUrl: './ganancias.component.html',
  styleUrls: ['./ganancias.component.scss']
})
export class GananciasComponent implements OnInit {
  public formRegistrar: FormGroup;
  dtOptions2: DataTables.Settings = {};
  dtTrigger2: Subject<any> = new Subject();
  info: any;
  producto = {id: '', imagen: '', nombre: '', descripcion: '', precio: '', productos_vendidos: '', total_ventas: '', Ganancia: ''};
  constructor(public ws: WsService, private formBuilder: FormBuilder, public router: Router, private httpClient: HttpClient) {
    // @ViewChild(DataTableDirective, {static: false}) dtElement: DataTableDirective;
    this.formulario();
  }

  ngOnInit(): void {
    this.dtOptions2 = {
      pageLength: 4,
      pagingType: 'full_numbers'
    }
    this.ws.WS_GANANCIAS().subscribe(data => {
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
      productos_vendidos: ['', Validators.required],
      total_ventas: [ '', Validators.required],
      Ganancia: ['', Validators.required]
    });
  }
}
