import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { Router} from "@angular/router";
import {FormBuilder, FormGroup, Validator, Validators} from "@angular/forms";
import {WsService} from '../../../services';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})

export class SidebarComponent implements OnInit {
  administrador: boolean = false;

  constructor(public router: Router, public ws: WsService) {
    this.ws.WS_RBAC({'rol':'administrador','token':localStorage.getItem('token')}).subscribe(data =>{
      console.log(data);
      if(data['success']===1){
        this.administrador=true;
      }
    });
  }

  ngOnInit(): void {

  }



}
