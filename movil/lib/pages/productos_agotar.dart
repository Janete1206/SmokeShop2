import 'package:movil/pages/clases.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosAgotar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title:  new Text('Productos Por Agotar',),
           
            backgroundColor: Color(0xff000000),
      ),
      body: new ListaProductosA(),
    );
  }
}


class ListaProductosA extends StatefulWidget {
  @override
  _ListaProductosAState createState() => _ListaProductosAState();
}

class _ListaProductosAState extends State<ListaProductosA> {

   Future<List<Productoa>> _getProductosA() async{
//var data = await http.get("http://192.168.10.204/smoke/api_productoAgotar.php");
   var data = await http.get("http://172.16.241.93/smoke/api_productoAgotar.php");
    var respuesta = json.decode(data.body);
    List<Productoa> productosa = [];

    for(var p in respuesta){
      Productoa productoa = Productoa( p['id'],
       p['imagen'],
        p['nombre'],
         p['descripcion'],
          p["precio"],
           p["stock"],
            p["stock_minimo"],
             p["codigo_barras"]);

      productosa.add(productoa);    
    }

    print(productosa.length);
 
    return productosa;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getProductosA(),
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
                    Icons.indeterminate_check_box,
                    size:50.0,
                    color:  Color(0xff000000),
                  ),
                  title: Text(snapshot.data[index].nombre),
                 subtitle: Text('Productos en existencia: '+ snapshot.data[index].stock),
           
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
class Productoa {

final String id;
final String imagen;
final String nombre;
final String descripcion;
final String precio;
final String stock;
final String stockminimo;
final String codigobarras;


Productoa(this.id, this.imagen, this.nombre, this.descripcion, this.precio, this.stock, this.stockminimo, this.codigobarras);

}