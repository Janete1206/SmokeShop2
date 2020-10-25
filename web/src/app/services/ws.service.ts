import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class WsService {
  constructor(public http: HttpClient) {
  }
  public producto = 'http://localhost/smoke/api_productos.php/';
  public usuario = 'http://localhost/smoke/api_usuario.php/';
  WS_LOGIN(data){
    return this.http.post(`${this.usuario}?login`, data);
  }
  // apartado productos
  // obtiene todos los productos
  WS_PRODUCTOS(){
    return this.http.get(`${this.producto}?getProducts`);
  }
  WS_AGREGARPRODUCTO(data){
    return this.http.post(`${this.producto}?insertProduct`, data);
  }
  WS_venta(data){
    return this.http.post('http://localhost/smoke/venta_prueba.php', data);
  }
  WS_postVenta(data){
    return this.http.post('http://localhost/smoke/post_venta.php', data);
  }
  // Inserta usuario
  WS_REGISTRO(data){
    return this.http.post(`${this.usuario}?insertaUsuario`, data);
  }
  WS_add_detalle(data){
    return this.http.post('http://localhost/smoke/add_detalle.php', data);
  }
  WS_GRAFICA(){
    return this.http.post('http://localhost/smoke/traer_ventas.php',{});
  }
  WS_DATATABLE(){
    return this.http.post('http://localhost/ws-p1/api_datatable2.php',{});
  }
  WS_PRODUCTOSAGOTAR(){
    return this.http.get('http://localhost/smoke/api_productoAgotar.php');
  }
  WS_UPDATEPRODUCT(data){
    return this.http.put('http://localhost/smoke/api_productos.php', data);
  }
  WS_DELETEPRODUCT(data){
    return this.http.post('http://localhost/smoke/api_productoo.php' , data);
 }
  WS_RBAC(data) {
    return this.http.post('http://localhost/smoke/api_rbac.php', data);
  }
  WS_PASSWORD(data) {
    return this.http.post('http://localhost/smoke/api_password_recovery.php', data);
  }
  // Actualizar contraseña de usuario dentro de su perfil
  WS_UPDATE_PASSWORD(data){
    return this.http.put(`${this.usuario}?actualizaContrasena`, data);
  }
}
