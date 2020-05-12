import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfoodie/datosReceta.dart';
import 'bufferDeRecetas.dart';
import 'modal.dart';
import 'solicitudReceta.dart';
import 'tarjeta.dart';
import 'listaDeLaCompra.dart';

class recetario30 extends StatelessWidget {
  //final String user;

  //const recetario30(this.user);

  Widget build(BuildContext context) {
    //Y si esto lo factorizamos en una nueva funcion
    //Que cuando esté
    var futurebuilder = new FutureBuilder(
      future: solicitudDatosReceta(),
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
              List<DatosReceta> recetas = snapshot.data;
              return new ListView.builder(
                itemCount: recetas.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      Tarjeta(recetas[index],
                          new Modal(),false,true,false
                      ),
                    ],
                  );
                },
              );
            }
        }
      },
    );

    ListView recetas30(List<DatosReceta> recetas){
      return new ListView.builder(
        itemCount: recetas.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              Tarjeta(recetas[index],
                  new Modal(),false,true,false
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: recetas30(Provider.of<listaDeLaCompra>(context).listaRecetas),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Borrar recetas"),
        onPressed: (){
          showDialog(
            context: context,
            builder: dialogoAlerta
          );
        }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
  Widget dialogoAlerta(BuildContext context){
    return CupertinoAlertDialog(
      title: Text("¿Eliminar todas las recetas?"),
      content: Text(
          "Si quieres conservar cualquier receta, pulsa en el corazón para agregarla a favoritos y conservarla para siempre",
          style: TextStyle(fontSize: 20),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("¡No!", style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Adelante",style: TextStyle(color: Theme.of(context).accentColor)),
          onPressed: () {
            Provider.of<listaDeLaCompra>(context, listen: false).reset();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}