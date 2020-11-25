import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ganancias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title:  new Text('Ganancias en el último mes',),
           
            backgroundColor: Color(0xff000000),
      ),
      body: new ListaGanancia(),
    );
  }
}


class ListaGanancia extends StatefulWidget {
  @override
  _ListaGananciaState createState() => _ListaGananciaState();
}

class _ListaGananciaState extends State<ListaGanancia> {

   Future<List<Gananciaa>> _getGananciaa() async{
//var data = await http.get("http://192.168.10.203/smoke/api_productoAgotar.php");
   var data = await http.get("http://192.168.1.71/smoke/api_productos.php/?getGanancia");
    var respuesta = json.decode(data.body);
    List<Gananciaa> ganancia = [];

    for(var p in respuesta){
      Gananciaa gananciasa = Gananciaa( p['id'],
       p['imagen'],
        p['nombre'],
         p['descripcion'],
          p["productos_vendidos"],
           p["totoal_ventas"],
            p["ganancia_generada"]);

      ganancia.add(gananciasa);    
    }

    print(ganancia.length);
 
    return ganancia;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getGananciaa(),
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
                    Icons.monetization_on,
                    size:50.0,
                    color:  Color(0xff000000),
                  ),
                  title: Text(snapshot.data[index].nombre),
                 subtitle: Text('Ganancias obtenidas: ' + snapshot.data[index].ganancia_generada),
           
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
class Gananciaa {

final String id;
final String imagen;
final String nombre;
final String descripcion;
final String productos_vendidos;
final String total_ventas;
final String ganancia_generada;


Gananciaa(this.id, this.imagen, this.nombre, this.descripcion, this.productos_vendidos, this.total_ventas, this.ganancia_generada);

}