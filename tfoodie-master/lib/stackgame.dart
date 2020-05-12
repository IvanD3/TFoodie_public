import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfoodie/datosReceta.dart';
import 'package:tfoodie/pantallaListaDeLaCompra.dart';
import 'bufferDeRecetas.dart';
import 'modal.dart';
import 'solicitudReceta.dart';
import 'tarjeta.dart';
import 'prefs.dart';
import 'listaDeLaCompra.dart';
import 'listaDeLaCompra.dart';
class stackGame extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: estructura(context),
    );
  }


  Widget estructura(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        marcadorDeRecetasAnadidas(context),
        primeraCarta(context),
        botonesFlotantes(context)
      ],
    );
  }
  Container marcadorDeRecetasAnadidas(
      BuildContext context) {
    return Container(
      child:
          Text("Recetas añadidas:   "+Provider.of<listaDeLaCompra>(context).numeroRecetas.toString(), style: TextStyle(fontSize: 28),),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
    );
  }
  Widget primeraCarta(BuildContext context) {
    return new Tarjeta(
        Provider.of<bufferDeRecetas>(context).frente(),
        new Modal(),
        false,false,false
    );
  }

  Container botonesFlotantes(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.clear),
              onPressed: (){
                Provider.of<bufferDeRecetas>(context, listen: false).pop();},
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.check),
              onPressed: (){
                DatosReceta dr = Provider.of<bufferDeRecetas>(context, listen: false).pop();
                print("Vamos a añadir");
                print(dr.toString());
                Provider.of<listaDeLaCompra>(context, listen: false).meGustaRecetas(dr);
                },
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }

}