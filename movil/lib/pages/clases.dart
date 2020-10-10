class Producto {

final int id;
final String imagen;
final String nombre;
final String descripcion;
final int precio;
final int stock;
final int stock_minimo;
final int codigo_barras;


Producto(this.id, this.imagen, this.nombre, this.descripcion, this.precio, this.stock, this.stock_minimo, this.codigo_barras);

}

class Proveedor {

final String id;
final String nombre;
final String telefono;
final String imagen;



Proveedor(this.id, this.nombre,this.telefono, this.imagen);

}