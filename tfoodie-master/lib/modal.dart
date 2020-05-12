import 'package:flutter/material.dart';
import 'package:tfoodie/datosReceta.dart';
class Modal{
  mainBottomSheet(BuildContext context, Ingredientes ingr){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              ),
          
        ),
        context: context,
        builder: (BuildContext context)
        {
          return ListView.builder(
              itemCount: ingr.longitud(),
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(ingr.texto(index)),
                );
              }
          );
          /*return ListView(
            children: <Widget>[

              _ingrediente(context,ingr),
             ],
          );*/
        }
    );
  }


  ListTile _createTile(BuildContext context, String nombre, IconData icon, Function action){
    return ListTile(
      leading: Icon(icon),
      title: Text(nombre),
      onTap: (){
        Navigator.pop(context);
        action();
      },
    );
  }
  ListTile _ingrediente(BuildContext context, List<dynamic> ingredientes){
    return ListTile(

      title: new Text(ingredientes[0].toString()),

    );
  }
}
