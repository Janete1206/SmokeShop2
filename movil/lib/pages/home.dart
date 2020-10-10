import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:movil/main.dart';
import 'package:movil/pages/clases.dart';
import 'package:movil/pages/perfil.dart';
import 'package:movil/pages/productos_agotar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movil/pages/agregarProducto.dart';
import 'package:movil/pages/agregarUsuario.dart';
import 'package:movil/pages/productos.dart';
import 'package:movil/pages/ventas.dart';
import 'package:movil/pages/proveedores.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  SharedPreferences sharedPreferences;
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  new Text('Cerrar Sesión',),
           
            backgroundColor: Color(0xff000000),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('token');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => LoginApp()));
          },
          child: Text('Logout'),
        ),
        
      ),
       drawer: Drawer(
        child: new ListView(
              children: <Widget>[
                new Divider(),
                new ListTile(
                  title: new Text("Ventas"),
                  trailing: new Icon(FontAwesomeIcons.chartLine),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  )),
                  ),
                  new Divider(),
               new ListTile(
                  title: new Text("Productos"),
                  trailing: new Icon(Icons.view_headline),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Productos(),
                  )),
                  ),
      
                  
                               
                 new Divider(),
                  new ListTile(
                  title: new Text("Productos Por Agotar"),
                  trailing: new Icon(Icons.check_box),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ProductosAgotar(),
                  )),
                  ), 
                  
                               
                 new Divider(),
                 new ListTile(
                  title: new Text("Agregar Usuario"),
                  trailing: new Icon(Icons.verified_user),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AgregarUsuario(),
                  )),
                  ), 
                  
                               
                 new Divider(),
                  new ListTile(
                  title: new Text("Proveedores"),
                  trailing: new Icon(Icons.supervised_user_circle),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Proveedores(),
                  )),
                  ), 
                    new Divider(),
                  new ListTile(
                  title: new Text("Perfil"),
                  trailing: new Icon(Icons.verified_user),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Perfil(),
                  )),
                  ), 
                  
                               
                 
                    new Divider(),
                  new ListTile(
                  title: new Text("Cerrar sesión"),
                  trailing: new Icon(Icons.closed_caption),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Home(),
                  )),
                  ), 
                  
                               
                 new Divider(),
               /* new ListTile(
                  title: new Text("Registrar Usuario"),
                  trailing: new Icon(Icons.verified_user),
                  onTap: () => {},                  
                ),*/
                
              ],
      ),
      ),
    );
  }
}


