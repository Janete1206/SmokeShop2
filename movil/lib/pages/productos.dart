import 'package:movil/pages/clases.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Productos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title:  new Text('Productos',),
           
            backgroundColor: Color(0xff000000),
      ),
      body: new ListaProductos(),
    );
  }
}


class ListaProductos extends StatefulWidget {
  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {

   Future<List<Producto>> _getProductos() async{
//var data = await http.get("http://192.168.10.203/smoke/api_producto.php");
   var data = await http.get("http://172.16.241.93/smoke/api_producto.php");
    var respuesta = json.decode(data.body);
    List<Producto> productos = [];

    for(var p in respuesta){
      Producto producto = Producto( p['id'],
       p['imagen'],
        p['nombre'],
         p['descripcion'],
          p["precio"],
           p["stock"],
            p["stock_minimo"],
             p["codigo_barras"]);

      productos.add(producto);    
    }

    print(productos.length);
 
    return productos;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getProductos(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                 child: Text('Cargando...'), 
                )
              );
            }else{
              return ListView.builder(
             
              itemCount: snapshot.data.length,
             
              itemBuilder: (BuildContext context, int index){

                return ListTile(
                  leading: /*Image.network(snapshot.data[index].imagen),*/Icon(
                    Icons.smoke_free,
                    size:50.0,
                    color:  Color(0xff000000),
                  ),
                  title: Text(snapshot.data[index].nombre),
                 subtitle: Text(snapshot.data[index].descripcion),
           
                  onTap: (){},
                );

              },
            );
            }
          },
          ),
      ),
    );
  }
}
class Producto {

final String id;
final String imagen;
final String nombre;
final String descripcion;
final String precio;
final String stock;
final String stockminimo;
final String codigobarras;


Producto(this.id, this.imagen, this.nombre, this.descripcion, this.precio, this.stock, this.stockminimo, this.codigobarras);

}