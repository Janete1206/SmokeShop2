import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movil/main.dart';
import 'package:movil/pages/updatePassword.dart';

class Perfil extends StatelessWidget {
  //final String email;

  @override
   Perfil(/*{Key key, @required this.email}*/) : super(/*key: key*/);
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
                username: /* '' +'\n'+ this.nombre*/ 'Janete Gamboa',
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
                   Text('janetegm19@gmail.com', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                )
                ),
                ],
                )
                ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) {
                     return PasswordPage();
                     })),
                     child: Container(
                       margin: new EdgeInsets.all(20.0),
                       alignment: Alignment.center,
                       decoration: ShapeDecoration(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30.0)),
                           color: Colors.black),
                     child: Text("Cambiar contraseña",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 18,
                       fontWeight: FontWeight.w500
                       )
                       ),
                       padding: EdgeInsets.only(top: 16, bottom: 16
                       ),
                    ),
                 )
              ],
          ),
      );
  }
}



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
