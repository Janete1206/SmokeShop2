import 'package:flutter/rendering.dart';
import 'package:movil/pages/clases.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movil/main.dart';

/*
updatePassword(String email, password)async{
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  
     //var response = await http.post("http://192.168.1.71/smoke/api_login.php",
   /
   var response = await http.post("http://192.168.1.71/smoke/update_password.php",
    body: jsonEncode(<String, String> {'password': password, 'email': email}));
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    //print('token generado:' + respuesta['token']);
    if(respuesta['success'] == 1){
      print('contresena cambiada');
      return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Éxito'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Contraseña cambiada'),
              Text(''),
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
              Text('Error alcambiar la contraseña'),
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
*/
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _newpasswordController = new TextEditingController();

class Perfil extends StatelessWidget {
  final String email;

  @override
   Perfil({Key key, @required this.email}) : super(key: key);
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: new Text(
            'Perfil',
          ),
          backgroundColor: Color(0xff000000),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Header(
                username: /* '' +'\n'+ this.nombre*/ 'Jacky Sanabria',
                backgroundAsset: 'assets/fondo.jpg',
                userAsset: 'assets/perfil.jpg',
              ),
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
       
                  Ventas(text: 'Ventas Mes Actual',number: 1256.21,),
                  Column(children:
                   <Widget>[Text('Correo Electronico', style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              )),
                 //  Text('' +'\n'+ this.email, style: TextStyle(
                   Text('sjackyb@hotmail.com', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
            
                   ],
                  )
                ],
              ),
              ),

             /* Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
            
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
                Text("Repetir contraseña: ",style: TextStyle(fontSize: 18.0),),
              Container(
                
                height: 50,
                
                child: new TextField(
                  
                  controller: _newpasswordController,
                   obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Contraseña',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
               new RaisedButton(
                     child: new Text("Cambiar contrseña"),
                     textColor: Colors.white,
                     color: Colors.black,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed: (){
                      // updatePassword( _passwordController.value.text, _newpasswordController.value.text);
                      
                     },
                   )
              ]
              )
              )*/
           
            ],
            
            ),
          
            
            
            );
       
          
  }
}
/*
class Forms extends StatelessWidget {

  const Forms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
            
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
                Text("Repetir contraseña: ",style: TextStyle(fontSize: 18.0),),
              Container(
                
                height: 50,
                
                child: new TextField(
                  
                  controller: _newpasswordController,
                   obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Contraseña',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
               new RaisedButton(
                     child: new Text("Cambiar contrseña"),
                     textColor: Colors.white,
                     color: Colors.black,
                     shape: new RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0)
                     ),
                     onPressed: (){
                      // updatePassword( _passwordController.value.text, _newpasswordController.value.text);
                      
                     },
                   )
              ]
              )
              );
  }
}

*/

class Ventas extends StatelessWidget {
  final String text;
  final double number;

  const Ventas({
    @required this.text,
    @required this.number,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white);
    return Column(children: <Widget>
    [Text(this.text, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              )),
     Text('${this.number}', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
     ],
    );
  }
}
class FotoPerfil extends StatelessWidget {
  final String assetsImage;
  final double size;

  const FotoPerfil({
    Key key,
    @required this.assetsImage,
    this.size = 100,
  }): super(key: key);
  @override 
  Widget build(BuildContext context){
    return Container(
                      width: this.size,
                      height: this.size,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(this.assetsImage),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, 
                          width: 3),
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                    );
  }
}
class Header extends StatelessWidget {
  final double height;
  final String backgroundAsset;
  final String userAsset;
  final String username;

  const Header({
    Key key,
    this.height= 200,
    @required this.backgroundAsset,
    @required this.userAsset,
    @required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.backgroundAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          FotoPerfil(assetsImage: this.userAsset,
          size: 100),
         
          Text(this.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              ))
        ],
      ),
    );
  }
}

String validatePassword(String value) {
   print("valorrr $value passsword ${_passwordController.text}");
   if (value != _passwordController.text) {
     return "Las contraseñas no coinciden";
   }
   return null;
 }
