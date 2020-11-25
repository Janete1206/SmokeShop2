import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:movil/pages/ganancias.dart';
import 'package:movil/pages/perfil.dart';
import 'dart:convert';
import 'package:movil/pages/productos.dart';
import 'package:movil/pages/productos_agotar.dart';
import 'package:movil/pages/proveedores.dart';

import 'agregarUsuario.dart';
import 'home.dart';
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Venta, int>> _seriesLineData;

Future<List<Venta>>_getVenta() async{
var data = await http.get("http://192.168.10.203/smoke/traer_venta.php");
    var respuesta = json.decode(data.body);
    List<Venta> ventas = [];

    for(var p in respuesta){
      Venta venta = Venta( 
        p['name'],
        p['data'],
      );
      ventas.add(venta);    
    }
   print(ventas.length);
    print(ventas);
 
    return ventas;
  }
  _generateData() {
    var data1 = [
      new Pollution(1980, 'Enero', 30),
      new Pollution(1980, 'Febrero', 40),
      new Pollution(1980, 'Marzo', 10),
    ];
    var data2 = [
      new Pollution(1985, 'Enero', 100),
      new Pollution(1980, 'Febrero', 150),
      new Pollution(1985, 'Marzo', 80),
    ];
    var data3 = [
      new Pollution(1985, 'Enero', 200),
      new Pollution(1980, 'Febrero', 300),
      new Pollution(1985, 'Marzo', 180),
    ];

    var piedata = [
      new Task('Pipa pyrex', 35.8, Color(0xff3366cc)),
      new Task('Vaporizador veneno kit', 8.3, Color(0xff990099)),
      new Task('Shisha', 10.8, Color(0xff109618)),
      new Task('Bong Cristal', 15.6, Color(0xfffdbe19)),
      new Task('Sábanas Raw', 19.2, Color(0xffff9900)),
      new Task('High Hemp', 10.3, Color(0xffdc3912)),
    ];

    var linesalesdata = [
      new Venta(1, 50),
      new Venta(2, 36),
      new Venta(3, 45),
      new Venta(4, 30),
      new Venta(5, 22),
      new Venta(6, 46),
      new Venta(7, 51),
      new Venta(8, 29),
      new Venta(9, 36),
      new Venta(10, 42),
      new Venta(11, 50),
      new Venta(12, 33),
    ];
/*    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
   
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];*/

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ), 
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
           charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
       fillColorFn: (Pollution pollution, _) =>
          charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
         labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data:linesalesdata,
        domainFn: (Venta sales, _) => sales.name,
        measureFn: (Venta sales, _) => sales.data,
      ),
    );
  /*  _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );*/
  }

  @override
  void initState() {
  
    // TODO: implement initState
    super.initState();
  /*  _getVenta();*/
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Venta, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff000000),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: new Text('Ventas'),
            
            
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Ventas Barras',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Productos más vendidos',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                             behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                           defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                             arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Ventas Línea',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.LineChart(
                            _seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                            behaviors: [
        new charts.ChartTitle('Meses',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Ventas',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('',
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
            )   
      ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                  trailing: new Icon(Icons.shopping_basket),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Productos(),
                  )),
                  ),
      
                              
                 new Divider(),
                  new ListTile(
                  title: new Text("Productos por agotar"),
                  trailing: new Icon(Icons.warning),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ProductosAgotar(),
                  )),
                  ), 

                  new Divider(),
                  new ListTile(
                  title: new Text("Perfil"),
                  trailing: new Icon(Icons.account_circle),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>Perfil(),
                  )),
                  ),
                  
                               
                 new Divider(),
                 new ListTile(
                  title: new Text("Agregar Usuario"),
                  trailing: new Icon(Icons.add_circle),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AgregarUsuario(),
                  )),
                  ),  
                  

                  new Divider(),
                   new ListTile(
                  title: new Text("Ganancias"),
                  trailing: new Icon(Icons.monetization_on),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Ganancias(),
                  )),
                  ),
                               
                  new Divider(),
                  new ListTile(
                  title: new Text("Proveedores"),
                  trailing: new Icon(Icons.contacts),
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
                  trailing: new Icon(Icons.exit_to_app),
                 onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Home(),
                  )),
                  ), 
              ],
      ),
      ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Venta {
  int name;
  int data;

  Venta(this.name, this.data);
}