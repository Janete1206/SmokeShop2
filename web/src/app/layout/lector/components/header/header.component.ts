import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { Router} from "@angular/router";
import {FormBuilder, FormGroup, Validator, Validators} from "@angular/forms";

@Component({
  selector: 'app-header2',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})

export class HeaderComponent implements OnInit {
  @Input() a: number;
  @Input() b: number;
  @Output() resutado = new EventEmitter();
  public suma: number;
  constructor(public router: Router) {

  }

  ngOnInit(): void {

    this.suma2();
  }

  suma2(){
    this.suma = this.a + this.b;
    this.resutado.emit(this.a + this.b);
  }
  accion(){
         this.router.navigate(['/']);
  }

}
