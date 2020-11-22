import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

const colorlogo = const Color(0xffECF3FA);
class RecoveryPage extends StatefulWidget {
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  TextEditingController controlleremail = new TextEditingController();
  String mensaje = '';
 

  login(String email)async{
 
     var response = await http.post("http://192.168.10.203/smoke/api_password_recovery.php",
     //var response = await http.post("http://192.168.10.204/smoke/api_password_recovery.php",
    body: jsonEncode(<String, String> {'email': email}));
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    if(respuesta['success'] == 1){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route)=> false);
    }else {
      print('Este usuario no existe');
      
 return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(' Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Este usuario no exite '),
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
               new Text("Recuperar contreseña", style: TextStyle(fontSize: 18),),
             Container(
               height: MediaQuery.of(context).size.height /2,
               width: MediaQuery.of(context).size.width,
               padding: EdgeInsets.only(
                 top: 60
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
                 Align(
                     alignment: Alignment.centerRight,
                     child: Padding(
                       padding: const EdgeInsets.only(
                         top: 15,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: <Widget>[
                       new RaisedButton(
                     child: new Text("Enviar"),
                     textColor: Colors.white,
                     color: Colors.black,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed: (){
                       login(controlleremail.value.text);
                     },
                   ),
                     ],
                     )
                      ]
                   ),
                   
                    new Center(
                      child: new InkWell(
                      child: new Text('Iniciar Sesión'),
                      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                      ),
                      ),
                     ),
                   ),
                    
                   Text(mensaje,
                   style: TextStyle(fontSize: 25.0, color: Colors.red),
                  ),
                 ],
               ),
             )
           ],
         )
         ),
    );
  }
}



