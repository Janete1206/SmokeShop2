import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validator, Validators} from "@angular/forms";
// import { WsService} from '../../services';
import {Router} from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  constructor(public router: Router) {
  }

  ngOnInit(): void {
  }

  cerrarSesion(){
    localStorage.clear();
    this.router.navigate(['/login']);
  }



}
