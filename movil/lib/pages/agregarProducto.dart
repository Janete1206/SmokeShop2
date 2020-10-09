import 'package:movil/main.dart';
import 'package:flutter/material.dart';

class AgregarProducto extends StatefulWidget {

  AgregarProducto ({Key key , this.title}) : super(key : key);
  final String title;

  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {



  final TextEditingController _nameController = new TextEditingController();  
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _stockController = new TextEditingController();
  final TextEditingController _urlController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuevo Producto',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Agregar Producto'),
            backgroundColor: Color(0xff000000),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Text("Nombre del Producto:",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Nombre producto',
                    icon: new Icon(Icons.palette),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),
                Text("Precio: ",style: TextStyle(fontSize: 18.0),),
              Container(
                
                height: 50,
                
                child: new TextField(
                  
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Precio del Producto',
                    icon: new Icon(Icons.monetization_on),
                  ),
                ),
              ),
              
              new Padding(padding: new EdgeInsets.only(top: 44.0),),
            Text("Cantidad en Stock: ",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Cantidad en stock',
                    icon: new Icon(Icons.save),
                  ),
                ),
              ),
               new Padding(padding: new EdgeInsets.only(top: 44.0),),
            Text("Url: ",style: TextStyle(fontSize: 18.0),),
              Container(
                height: 50,
                child: new TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'url de la imagen del producto',
                    icon: new Icon(Icons.unfold_more),
                  ),
                ),
              ),
            

            ],
          ),
        ),
      ),
    );
  }



}
