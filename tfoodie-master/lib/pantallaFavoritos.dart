import 'package:flutter/material.dart';
import 'package:tfoodie/datosReceta.dart';
import 'modal.dart';
import 'solicitudReceta.dart';
import 'tarjeta.dart';
import 'favoritos.dart';
import 'package:provider/provider.dart';
class pantallaFavoritos extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: recetasPreferidas(Provider.of<favoritos>(context).recetasFavoritas),
    );
  }
  ListView recetasPreferidas(List<DatosReceta> recetas){
    return new ListView.builder(
      itemCount: recetas.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            Tarjeta(recetas[index],
                new Modal(),true,true,true
            ),
          ],
        );
      },
    );
  }
}