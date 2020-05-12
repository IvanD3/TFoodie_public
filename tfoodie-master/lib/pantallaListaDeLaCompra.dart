import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfoodie/datosReceta.dart';
import 'bufferDeRecetas.dart';
import 'listaDeLaCompra.dart';
import 'modal.dart';
import 'solicitudReceta.dart';
import 'tarjeta.dart';
class listaCompra extends StatelessWidget {
  Widget imagen(String URL){
    return Image.network(
      URL,
    );
  }

  Widget tarjetasCompra(BuildContext context, int indiceTarjeta) {
    //tarjetaDeLaCompra dr = Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta);
    return Column(
      children: <Widget>[
        for(var i = 0; i < Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).longitudListaDeLaCompra; i++)
            if(!Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).comprado(i))
              ListTile(
                title: Text(Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).ingredientes(i),
                  style: TextStyle(
                    decorationColor: Theme.of(context).accentColor,
                    decorationThickness: 3,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
                enabled: true,
                onTap: (){
                  Provider.of<listaDeLaCompra>(context,listen: false).cambiarValor(indiceTarjeta, i);
                },
              ),
        for(var i = 0; i < Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).longitudListaDeLaCompra; i++)
        if(Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).comprado(i))
              ListTile(
                title: Text(Provider.of<listaDeLaCompra>(context).receta(indiceTarjeta).ingredientes(i),
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Theme.of(context).accentColor,
                    decorationThickness: 3,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
                enabled: true,
                onTap: (){
                  Provider.of<listaDeLaCompra>(context,listen: false).cambiarValor(indiceTarjeta, i);
                },
              ),
      ],
    );
  }
  /*
  Widget tarjetasCompra(BuildContext context, int indiceTarjeta) {
    tarjetaDeLaCompra dr = Provider.of<listaDeLaCompra>(context).receta(
        indiceTarjeta);
    return Column(
        children: <Widget>[
    for(var i = 0; i<dr.longitudListaDeLaCompra;i++){
        ListTile(
          title: Text(
            Provider.of<listaDeLaCompra>(context).receta(index).ingredientes(
                indexCompras),
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Theme
                  .of(context)
                  .accentColor,
              decorationThickness: 3,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
          enabled: true,
          onTap: () {
            Provider.of<listaDeLaCompra>(context, listen: false)
                .receta(index)
                .cambiarValor(indexCompras);
          },
        ),
    }

        ],
    );
  }*/
  Widget build(BuildContext context) {
    ListView ingredientes(BuildContext context){
      return new ListView.builder(
          itemCount: Provider.of<listaDeLaCompra>(context).numeroRecetas,
          itemBuilder: (BuildContext context, int index) {
            return FractionallySizedBox(
              widthFactor: 0.91,
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                elevation: 3,
                borderOnForeground: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    imagen(Provider.of<listaDeLaCompra>(context).receta(index).imagen),
                    SizedBox(height: 20),
                    tarjetasCompra(context, index)
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
        body: ingredientes(context)
    );
  }
}

/*
class listaCompra extends StatelessWidget {

  Widget build(BuildContext context) {
    ListView ingredientes(List<String> ingredientes, List<bool>comprado){
      return new ListView.builder(
        itemCount: ingredientes.length,
        itemBuilder: (BuildContext context, int index) {
          if(!comprado[index]){
            return ListTile(
              title: Text(ingredientes[index]),
              enabled: true,
              onTap: (){
                Provider.of<listaDeLaCompra>(context, listen: false).cambiarValor(index);
              },
            );
          }
        else{
          return ListTile(
          title: Text(ingredientes[index],
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Theme.of(context).accentColor,
              decorationThickness: 3,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
          enabled: true,
          onTap: (){
              Provider.of<listaDeLaCompra>(context, listen: false).cambiarValor(index);
            },
      );
      }

    });
    }

    return Scaffold(
        body: ingredientes(
            Provider.of<listaDeLaCompra>(context).listaCompra,
            Provider.of<listaDeLaCompra>(context).comprado
        )
    );
  }
}*/
/*

new ListView.builder(
itemCount: Provider.of<listaDeLaCompra>(context).receta(index).longitudListaDeLaCompra,
itemBuilder: (BuildContext context, int indexCompras) {
if(!Provider.of<listaDeLaCompra>(context).receta(index).comprado(indexCompras)){
return ListTile(
title: Text(Provider.of<listaDeLaCompra>(context).receta(index).ingredientes(indexCompras)),
enabled: true,
onTap: (){
Provider.of<listaDeLaCompra>(context, listen: false).receta(index).cambiarValor(indexCompras);
},
);
}
else{
return ListTile(
title: Text(Provider.of<listaDeLaCompra>(context).receta(index).ingredientes(indexCompras),
style: TextStyle(
color: Colors.grey,
decoration: TextDecoration.lineThrough,
decorationColor: Theme.of(context).accentColor,
decorationThickness: 3,
decorationStyle: TextDecorationStyle.solid,
),
),
enabled: true,
onTap: (){
Provider.of<listaDeLaCompra>(context, listen: false).receta(index).cambiarValor(indexCompras);
},
);}}),

*/