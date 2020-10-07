import {Component, OnInit, ViewChild} from '@angular/core';
import { WsService} from '../../services';
import { FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import Swal from 'sweetalert2';
import {Router} from '@angular/router';

@Component({
  selector: 'app-tablas',
  templateUrl: './lector.component.html',
  styleUrls: ['./lector.component.scss']
})
export class LectorComponent implements OnInit {
  userTable: FormGroup;
  control: FormArray;
  mode: boolean;
  touchedRows: any;
  public formcodigo: FormGroup;

  constructor(private formBuilder: FormBuilder, public ws: WsService, private fb: FormBuilder, public router: Router) {
   // @ViewChild(DataTableDirective, {static: false}) dtElement: DataTableDirective;
    this.formulario();
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
    this.formcodigo = this.formBuilder.group({
      codigo_barras: ['']
    });
  }
  mostrarCodigo() {
    const informacion = this.formcodigo.value;
    console.log(informacion);
    this.formcodigo.reset();
  }

}
