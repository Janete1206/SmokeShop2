import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { Router} from "@angular/router";
import {FormBuilder, FormGroup, Validator, Validators} from "@angular/forms";

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})

export class HeaderComponent implements OnInit {
  public usuario;

  constructor(public router: Router) {
    this.usuario= localStorage.getItem('usuario');
  }

  ngOnInit(): void {

  }
  cerrarSesion(){
    localStorage.clear();
    this.router.navigate(['/login']);
  }


}
