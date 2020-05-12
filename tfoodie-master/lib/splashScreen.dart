import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bufferDeRecetas.dart';
import 'favoritos.dart';
import 'package:tfoodie/datosReceta.dart';
import 'listaDeLaCompra.dart';
import 'modal.dart';
import 'solicitudReceta.dart';
import 'tarjeta.dart';
import 'home.dart';
import 'autentificacion.dart';

class splashScreen extends StatelessWidget {
  final String user;
  final interfazAutentificacion auth;
  final VoidCallback logoutCallback;
  const splashScreen({this.user,this.auth, this.logoutCallback});
  Widget build(BuildContext context) {
    print("Entrada al splash screen");
    return Scaffold(
              body: preparacion(context),

    );
  }
  /*Widget build(BuildContext context) {
    return Scaffold(
      body: preparacion(),
    );
  }*/

  FutureBuilder preparacion(BuildContext context){
    print("Preparacion de todo esto");
    return new FutureBuilder(
      future: cargarDatos(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(),);
            return new Text('Esperando...');
          default:
            if (snapshot.hasError)
              return new Text(
                  'Ha ocurrido el siguiente error: ${snapshot.error}');
            else{
              return new Home(
                user: user,
                auth: auth,
                logoutCallback: logoutCallback,
              );
            }
        }
      },
    );
  }
  Future<bool> cargarDatos(context)async{
  if(await Provider.of<favoritos>(context, listen: false).cargarRecetasFavoritas())
    print("Favoritos cargados con éxito");
  if(await Provider.of<bufferDeRecetas>(context, listen: false).cargarBuffer())
    print("Buffer cargado con éxito");
  if(await Provider.of<listaDeLaCompra>(context, listen: false).generarListaRecetas())
    print("Lista de la compra cargada con éxito");
  return true;
}


}