import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class WsService {
  constructor(public http: HttpClient) {
  }
  public producto = ' https://smokeshopleo.000webhostapp.com/public_html/api_productos.php/';
  public usuario = 'https://smokeshopleo.000webhostapp.com/public_html/api_usuario.php/';
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
    return this.http.post(`${this.producto}?getProductsVentas`, data);
  }
  WS_postVenta(data){
    return this.http.post('http://localhost/smoke_api/post_venta.php', data);
  }
  // Inserta usuario
  WS_REGISTRO(data){
    return this.http.post(`${this.usuario}?insertaUsuario`, data);
  }
  WS_add_detalle(data){
    return this.http.post('http://localhost/smoke_api/add_detalle.php', data);
  }
  WS_GRAFICA(){
    return this.http.post('http://localhost/smoke_api/traer_ventas.php',{});
  }
  WS_DATATABLE(){
    return this.http.post('http://localhost/ws-p1/api_datatable2.php',{});
  }
  WS_PRODUCTOSAGOTAR(){
    return this.http.get('http://localhost/smoke_api/api_productoAgotar.php');
  }
  WS_UPDATEPRODUCT(data){
    return this.http.put(`${this.producto}?updateProduct`, data);
  }
  WS_DELETEPRODUCT(data){
    return this.http.post(`${this.producto}?deleteProduct` , data);
 }
  WS_RBAC(data) {
    return this.http.post('http://localhost/smoke_api/api_rbac.php', data);
  }
  WS_PASSWORD(data) {
    return this.http.post('http://localhost/smoke_api/api_password_recovery.php', data);
  }
  // Actualizar contraseña de usuario dentro de su perfil
  WS_UPDATE_PASSWORD(data){
    return this.http.put(`${this.usuario}?actualizaContrasena`, data);
  }
  WS_GANANCIAS(){
    return this.http.get(`${this.producto}?getGanancia`);
  }
  WS_Generar_reporte(data){
    return this.http.post(`${this.producto}?generaReporte`, data);
  }
  WS_generar_pdf(data){
    return this.http.post('http://localhost/smoke_api/generacion_pdf/generar_reporte.php', data);
  }
}
