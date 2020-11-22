
import 'package:movil/main.dart';
import 'package:flutter/material.dart';
import 'package:movil/pages/agregarProducto.dart';
import 'package:movil/pages/agregarUsuario.dart';
import 'package:movil/pages/productos.dart';
import 'package:movil/pages/home.dart';
import 'package:smart_select/smart_select.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movil/pages/productos_agotar.dart';
import 'package:movil/pages/ventas.dart';
import 'package:movil/pages/proveedores.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AgregarUsuario extends StatefulWidget {

  AgregarUsuario ({Key key , this.title}) : super(key : key);
  final String title;

  @override
  _AgregarUsuarioState createState() => _AgregarUsuarioState();
}
 


class _AgregarUsuarioState extends State<AgregarUsuario> {
  var status;

/*void addUser(String _nombreController, String _emailController, String _passwordController, String _rolController) async {
 
   String myUrl = "http://192.168.1.71/smoke/api_usuario.php";
   final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "nombre":       "$_nombreController",
          "email":      "$_emailController",        
          "password":      "$_passwordController",
          "rol":      "$_rolController"

        } ) ;
    // = response.body.contains('error');
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    if(respuesta['success'] == 1){
      print('Usuario registrado');
    }else{
      print('Eror');
    }
  }*/
 
  addUser(String nombre, email, password, rol)async{
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Janete
     //var response = await http.post("http://192.168.1.71/smoke/api_login.php",
   //Jacqueline
   //var response = await http.post("http://192.168.10.203/smoke/api_login.php",
   //var response = await http.post("http://192.168.10.203/smoke/api_usuario.php",
   var response = await http.post("http://192.168.1.71/smoke/api_usuario.php",
    body: jsonEncode(<String, String> {'nombre': nombre, 'email': email, 'password': password, 'rol': rol}));
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    //print('token generado:' + respuesta['token']);
    if(respuesta['success'] == 1){
      print('Usuario agregado');
      return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Éxito'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Usuario agregado'),
              Text('El usuario ahora puede iniciar sesión'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
    }else{
      print('Error');
      return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Error al registrar el usuario'),
              Text('Intenta de nuevo!'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
    }
  }

  final TextEditingController _nombreController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController(); 
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _rolController = new TextEditingController();
   
  String value = 'roles';
List<SmartSelectOption<String>> options = [
  SmartSelectOption<String>(value: 'vendedor', title: 'Vendedor'),
  SmartSelectOption<String>(value: 'administrador', title: 'Administrador'),

];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //title: 'Nuevo Usuario',
      //home: Scaffold(
        appBar: AppBar(
          title:  new Text('Agregar Usuario',),
           
            backgroundColor: Color(0xff000000),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Text("Nombre:",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _nombreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Nombre',
                    icon: new Icon(Icons.supervised_user_circle),
                  ),
                ),
              ),

                 new Padding(padding: new EdgeInsets.only(top: 44.0),),
            Text("Correo ",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Correo electronico',
                    icon: new Icon(Icons.mail),
                  ),
                ),
              ),
            
              new Padding(padding: new EdgeInsets.only(top: 44.0),),
                Text("Contraseña: ",style: TextStyle(fontSize: 18.0),),
              Container(
                
                height: 50,
                
                child: new TextField(
                  
                  controller: _passwordController,
                   obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Contraseña',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              
          
               new Padding(padding: new EdgeInsets.only(top: 44.0),),
               new SmartSelect<String>.single(
    title: 'Rol',
    value: value,
    options: options,
    onChange: (val) => setState(() => value = val,)
  ),
            /*Text("Rol ",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _rolController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'rol',
                    icon: new Icon(Icons.verified_user),
                  ),
                ),
                
              ),*/
              new Divider(),
            new RaisedButton(
                     child: new Text("Agregar Usuario"),
                     textColor: Colors.white,
                     color: Colors.black,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed: (){
                       addUser(_nombreController.value.text, _emailController.value.text, _passwordController.value.text, _rolController.value.text);
                       //Navigator.popAndPushNamed(context, '/home');
                     },
                   ),

            ],
          ),
        ),
           /*drawer: Drawer(
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
      ),*/
      //),
      
    );
  }



}
