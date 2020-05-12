import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:tfoodie/datosReceta.dart';
import 'package:tfoodie/favoritos.dart';
import 'package:tfoodie/modal.dart';
import 'datosReceta.dart';
import 'package:toast/toast.dart';
import 'listaDeLaCompra.dart';

class Tarjeta extends StatelessWidget{
  DatosReceta _receta;
  Modal _modal;
  bool _esFavorita;
  bool _fav;
  bool _compra;
  Tarjeta(this._receta,this._modal,this._esFavorita,this._fav,this._compra);
  @override
  Widget build(BuildContext context) {
    return tarjeta(context);
  }

  //Widget que modela la tarjeta de receta
  Widget tarjeta(BuildContext context){
    return FractionallySizedBox(
      widthFactor: 0.91,
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
        elevation: 3,
        borderOnForeground: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            imagen(context),
            SizedBox(height: 20),
            textoTitular(context),
            botoneraInferior(context, _receta),
          ],
        ),
      ),
    );
  }

  Widget imagen(BuildContext context){
    return Image.network(
      _receta.imagenURL,
    );
  }
  //Widget para modelar el texto del titular de la receta
  Widget textoTitular(BuildContext context){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      dense: false,
      //leading: Icon(Icons.restaurant_menu),
      title: Text(_receta.nombre, style: TextStyle(fontSize: 20),),
    );
  }

  //Barra de botones para la tarjeta
  Widget botoneraInferior(BuildContext context,DatosReceta receta){
    return ButtonBar(
      children: <Widget>[
        if(_compra)
          botonCompra(context, receta),
        if(_fav)
          FavoriteWidget(receta,_esFavorita),
        SizedBox(width: 30),
        listaIngredientes(context),
        leerMas(context),
      ],
    );
  }

  Widget botonCompra(BuildContext context, DatosReceta dr){
    return IconButton(
        icon: Icon(Icons.add_box),
      onPressed: (){
        Provider.of<listaDeLaCompra>(context, listen: false).meGustaRecetas(dr);
        snack(context, "Receta favorita añadida a lista de la compra", 3);
        }
    );
  }

  snack(BuildContext context, String texto, int tiempo){
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content:Text(
            texto,
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.25),
          ),
          duration: Duration(seconds: tiempo),
          backgroundColor: Theme.of(context).backgroundColor,
        )
    );
  }

  //Widget para el botón de mostrar la lista de ingredientes
  Widget listaIngredientes(BuildContext context){
    return OutlineButton(
        child: Text("Ingredientes"),
      onPressed: ()=> this._modal.mainBottomSheet(context,_receta.ingredientes),
    );
  }

  //Widget para el botón de leer más
  Widget leerMas(BuildContext context){
    return OutlineButton(
      child: Text("Leer más"),
      onPressed: ()=> abrirPagina(context,_receta.recetaURL),
    );
  }

  void abrirPagina(BuildContext context, String URL) async {
    try {
      await launch(
        URL,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          //animation: new CustomTabsAnimation.slideIn()
          // or user defined animation.
          animation: new CustomTabsAnimation(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}

class FavoriteWidget extends StatefulWidget{
  DatosReceta _dr;
  bool _f;
  FavoriteWidget(DatosReceta dr,bool f){this._dr=dr;this._f=f;}
  _FavoriteWidgetState createState() => _FavoriteWidgetState(_dr,_f);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  DatosReceta _dr;
  bool _favorito;
  _FavoriteWidgetState(DatosReceta dr,bool favorito){
    this._dr = dr;
    this._favorito = favorito;
  }
  @override
  snack(String texto, int tiempo){
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content:Text(
            texto,
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.25),
          ),
          duration: Duration(seconds: tiempo),
          backgroundColor: Theme.of(context).backgroundColor,
        )
    );
  }

  Widget build(BuildContext context) {
    final fav= Provider.of<favoritos>(context);
    return IconButton(
      icon: (_favorito ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),color: Theme.of(context).accentColor,
      onPressed: () => setState(() {
        if (!_favorito) {
          print("Receta "+_dr.devolverID()+" agregada a favoritos");
          //Toast.show("Receta "+_dr.nombre+" agregada a favoritos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          snack("Receta "+_dr.nombre+" agregada a favoritos",2);
          fav.agregar(_dr);
          _favorito = !_favorito;
        } else {
          snack("Receta eliminada de favoritos.\n¡ATENCIÓN! vuelve a pulsar el corazón para no perder la receta",5);
          fav.eliminar(_dr);
          _favorito = !_favorito;
        }
      }
      ),
    );
  }
}


