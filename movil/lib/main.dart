import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movil/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:movil/pages/passwordRecovery.dart';
import 'package:movil/pages/ventas.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(LoginApp());

String username;
const colorlogo = const Color(0xffECF3FA);
class LoginApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFECF3FA)),
      home: LoginPage(),
      
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
      },
    );
  }
}
class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();

  String mensaje = '';

  login(String email, password)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Janete
    var response = await http.post("http://192.168.1.71/smoke/api_login.php",
   //Jacqueline
   //var response = await http.post("http://192.168.10.203/smoke/api_login.php",
    
    body: jsonEncode(<String, String> {'email': email, 'password': password}));
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    if(respuesta['success'] == 1){
      print('token generado:' + respuesta['token']);
      print('usuario:' + respuesta['email']);
      sharedPreferences.setString("token", respuesta['token']);
      sharedPreferences.setString("email", respuesta['email']);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route)=> false);
    }else if(respuesta['success'] == 0) {
      print('Error de credenciales');
 return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(' Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Error correo y/o contraseña no coinciden'),
              Text('Por favor, vuelve a ingresar los datos.'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomPadding: false,
       body: Form(
         child: Column(
           
           children: <Widget>[
             new Container(
               padding: EdgeInsets.only(top: 100.0),
                 child: 
                    Image.asset(
                        'assets/logosmokeshop.jpg',
                         width: 210.0,
                         height: 190.0,
                      ),
               decoration: BoxDecoration( 
                 shape: BoxShape.circle
               ),       
             ), 
             Container(
               height: MediaQuery.of(context).size.height /2,
               width: MediaQuery.of(context).size.width ,
               padding: EdgeInsets.only(
                 top: 50
               ),
               child: Column(
                 children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width / 1.2,
                     padding: EdgeInsets.only(
                       top: 4, left: 16, right: 16, bottom: 4
                     ),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(50)),
                       color: colorlogo,
                  
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black12,
                           blurRadius: 5
                         )
                       ]
                     ),
                     child: TextFormField(
                       controller: controlleremail,
                       decoration: InputDecoration(
                         icon: Icon(
                           Icons.email,
                           color: Colors.black,
                         ),
                         hintText: 'Correo electrónico'
                       ),
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width / 1.2,
                     height:50,
                     margin: EdgeInsets.only(
                       top: 32
                     ),
                     padding: EdgeInsets.only(
                       top:4, left: 16, right: 16, bottom:4
                     ),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(50)),
                       color: colorlogo,
                       boxShadow:[
                         BoxShadow(
                           color: Colors.black12,
                           blurRadius: 5
                         )
                       ]
                     ),
                     child: TextField(
                       controller: controllerpassword,
                       obscureText: true,
                       decoration: InputDecoration(
                         icon: Icon (
                           Icons.vpn_key,
                           color: Colors.black,
                         ),
                         hintText: 'Contraseña'
                       ),
                     ),
                   ),
                 Align(
                     alignment: Alignment.centerRight,
                     child: Padding(
                       padding: const EdgeInsets.only(
                         top: 2,
                         right: 32,
                       ),
                       child: Text(
                         '',
                         style: TextStyle(
                           color: Colors.grey,
                          ),
                       ),
                     ),
                   ),
                  // Spacer(),
                   Column (
                      mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Row(
                         //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         //mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                       new RaisedButton(
                     child: new Text("Iniciar Sesión"),
                     textColor: Colors.white,
                     color: Colors.black,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed: (){
                       login(controlleremail.value.text, controllerpassword.value.text);
                       //Navigator.popAndPushNamed(context, '/home');
                     },
                   ),
                     ],
                     )
                      ]
                   ),
                   Column (
                      mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Row(
                         //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         //mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                   new Center(
                      child: new InkWell(
                     child: new Text('¿Olvidaste tu contraseña?'),
                      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => RecoveryPage(),
                      ),
                      ),
          ),
                   ),
                     ],
                     )
                      ]
                   ),
                    
                    
                   
                   Text(mensaje,
                   style: TextStyle(fontSize: 25.0, color: Colors.red),
                  ),
                 ],
               )
             )
           ],
         )
         ),
    );
  }
}
