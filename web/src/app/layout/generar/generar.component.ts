import {Component, OnInit, ViewChild} from '@angular/core';
import { WsService} from '../../services';
import {Subject} from "rxjs";
import {DataTableDirective} from "angular-datatables";
import { Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import Swal from "sweetalert2";
import {HttpClient} from '@angular/common/http';
import {consoleTestResultHandler} from 'tslint/lib/test';
import { PdfMakeWrapper } from 'pdfmake-wrapper';
import pdfFonts from 'pdfmake/build/vfs_fonts'; // fonts provided for pdfmake
import { Txt, Columns, Img, Table, Cell  } from 'pdfmake-wrapper';

// Set the fonts to use
PdfMakeWrapper.setFonts(pdfFonts);

@Component({
  selector: 'app-generar',
  templateUrl: './generar.component.html',
  styleUrls: ['./generar.component.scss']
})
export class GenerarComponent implements OnInit {
  public formRegistrar: FormGroup;
  dtOptions2: DataTables.Settings = {};
  dtTrigger2: Subject<any> = new Subject();
  info: any;
  constructor(public ws: WsService, private formBuilder: FormBuilder, public router: Router, private httpClient: HttpClient) {
    // @ViewChild(DataTableDirective, {static: false}) dtElement: DataTableDirective;
    this.formulario();
  }

  ngOnInit(): void {
    this.dtOptions2 = {
      pageLength: 4,
      pagingType: 'full_numbers'
    };
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
      fecha_inicio: ['', Validators.required],
      fecha_final: [ '', Validators.required],
    });
  }
  get fecha_inicio(){
    return this.formRegistrar.get('fecha_inicio');
  }
  get fecha_final(){
    return this.formRegistrar.get('fecha_final');
  }

  Generar_reporte(){
    const provider = this.formRegistrar.value;
    // console.log(this.formLogin.value.usuario);
    console.log(provider);
    this.ws.WS_Generar_reporte(provider).subscribe(data => {
      console.log(data);
      if ( data['status'] === true){
        Swal.fire("Reporte generado!", "Revise en la carpeta", "success");
      }else if (data['status'] === false){
        Swal.fire("Error", "Ya se realizo el reporte de hoy!", "error",);
      }
    });
  }
  Generar_reporte_pdf(){
    const provider = this.formRegistrar.value;
    const fecha = this.formRegistrar.value.fecha_inicio;
    const fechaFinal = this.formRegistrar.value.fecha_final;
    console.log(provider);
    const pdf = new PdfMakeWrapper();
    pdf.header('Smoke Shop Leo');
    pdf.add(new Txt('Reporte de ventas y ganancias de ' + fecha + ' a ' + fechaFinal )
      .bold().decoration('underline') .alignment('center').end);
    this.ws.WS_generar_pdf(provider).subscribe(data => {
      console.log(data);
      pdf.add( new Columns([' Nombre ', 'Descripción', 'precio', 'Productos vendidos' , 'Total ventas', 'Ganancias'])
        .bold().end);
      for (const i in  data){
        const nombre = data[i]['nombre'];
        const descripcion = data[i]['descripcion'];
        const precio = data[i]['precio'];
        const productosVendidos = data[i]['productos_vendidos'];
        const totalVentas = data[i]['total_ventas'];
        const ganancia = data[i]['Ganancia'];
        console.log(nombre);
        pdf.add( new Columns(
          [ nombre , descripcion, precio, productosVendidos, totalVentas, ganancia]).columnGap(5) .width( 100).end);
      }
      pdf.footer('Reporte de ventas Smoke Shop Leo');
      pdf.pageMargins([ 40, 60, 40, 60 ]);
      pdf.create().download('Reporte de ' + fecha + ' a ' + fechaFinal);
    });
  }
}
