import 'package:flutter/material.dart';
import 'package:tfoodie/bufferDeRecetas.dart';
import 'package:tfoodie/listaDeLaCompra.dart';
import 'package:tfoodie/ruta.dart';
import 'pantalla30.dart';
import 'home.dart';
//import '../sampledata/paginaInicio.dart';
import 'package:provider/provider.dart';
import 'favoritos.dart';
import 'registroylogin.dart';
import 'autentificacion.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => favoritos()),
        ChangeNotifierProvider(create: (context) => listaDeLaCompra()),
        ChangeNotifierProvider(create: (context) => bufferDeRecetas()),
      ],
    child:MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent,
          unselectedWidgetColor: Colors.black38,
          //canvasColor: Color.fromRGBO(200, 200, 200, 255),
          buttonBarTheme: ButtonBarThemeData(
          ),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.deepOrange,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepOrangeAccent,
            unselectedWidgetColor: Colors.white38,
            //canvasColor: Colors.black26
        ),
        home: RootPage(auth: new autentificacion()),
    ),
    );
  }
}
