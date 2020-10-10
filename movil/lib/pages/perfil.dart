import 'package:flutter/rendering.dart';
import 'package:movil/pages/clases.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Perfil extends StatelessWidget {
  @override
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
                username: 'Jacky Sanabria',
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
                   Text('sjackyb@hotmail.com', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
            
                   ],
                  )
                ],
              ),
              ),
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

