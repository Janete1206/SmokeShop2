import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PasswordPage extends StatefulWidget {
 @override
 _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
 GlobalKey<FormState> keyForm = new GlobalKey();
 TextEditingController  passwordCtrl = new TextEditingController();
 TextEditingController  repeatPassCtrl = new TextEditingController();

  updatePass(String password)async{
     if (keyForm.currentState.validate()) {
     //print("password ${passwordCtrl.text}");
         keyForm.currentState.reset();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.put("http://192.168.1.71/smoke/update_password.php",
    body: jsonEncode(<String, String> {'email': sharedPreferences.get('email'), 'password': password}));
    var respuesta = json.decode(response.body);
    print(respuesta['success']);
    if(respuesta['success']==1){
      print('Contraseña actualizada :)');
      return showDialog <void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Correcto'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Tu contraseña ha sido'),
              Text('actualizada correctamente.'),
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
      print('Ops! Ocurrio un error :(');
    }
  }
  }
  
 @override
 Widget build(BuildContext context) {
   
   return Scaffold(
       appBar: new AppBar(
         title: new Text('Cambiar Contraseña'),
         backgroundColor: Color(0xff000000),
       ),
       body: new SingleChildScrollView(
         child: new Container(
           margin: new EdgeInsets.all(60.0),
           child: new Form(
             key: keyForm,
             child: formUI(),
           ),
         ),
       ),
   );
 }

 formItemsDesign(icon, item) {
   return Padding(
     padding: EdgeInsets.symmetric(vertical: 15),
     child: Card(child: ListTile(leading: Icon(icon), title: item)),
   );
 }

 String gender = 'hombre';

 Widget formUI() {
   return  Column(
     children: <Widget>[
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: passwordCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Contraseña',
             ),
           )),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: repeatPassCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Repetir Contraseña'
             ),
             validator: validatePassword,
           )),
   GestureDetector(
   onTap: (){
     //save();
     updatePass( passwordCtrl.value.text);
   },child: Container(
         margin: new EdgeInsets.all(20.0),
         alignment: Alignment.center,
         decoration: ShapeDecoration(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0)),
               color: Colors.black
         ),
         child: Text("Guardar",
             style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w500)),
         padding: EdgeInsets.only(top: 16, bottom: 16),
       ),),
     ],
   );
 }
 String validatePassword(String value) {
   //print("valorrr $value passsword ${passwordCtrl.text}");
   if (value != passwordCtrl.text) {
     return "Las contraseñas no coinciden";
   }
   return null;
 }
 save() {
   if (keyForm.currentState.validate()) {
     print("pass ${passwordCtrl.text}");
         keyForm.currentState.reset();
         this.updatePass(passwordCtrl.value.text);
   }
 }
}
