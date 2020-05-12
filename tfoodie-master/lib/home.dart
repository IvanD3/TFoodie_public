import 'package:flutter/material.dart';
import 'autentificacion.dart';
import 'pantalla30.dart';
import 'package:tfoodie/pantallaFavoritos.dart';
import 'stackgame.dart';
import 'pantallaListaDeLaCompra.dart';
class Home extends StatefulWidget {
  final String user;
  final interfazAutentificacion auth;
  final VoidCallback logoutCallback;
  const Home({this.user,this.auth, this.logoutCallback});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _user = '';
  String navegacion = "Planificación";

  List<Widget> _children = [
    stackGame(),
    recetario30(),
    listaCompra(),
    pantallaFavoritos(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch(index){
        case 0:
          navegacion = "Planificación";
          break;
        case 1:
          navegacion = "Menús elegidos";
          break;
        case 2:
          navegacion = "Lista de la compra";
          break;
        case 3:
          navegacion = "Recetas favoritas";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navegacion),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text("Salir"),
              IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: widget.logoutCallback,
              ),
            ],
          )

        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: barraInferior(),
    );
  }

  //WIDGET QUE MODELA LA BARRA INFERIOR
  Widget barraInferior(){
    return BottomNavigationBar(
      showUnselectedLabels: true,
      elevation: 30,
      onTap: onTabTapped, // new
      currentIndex: _currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Inicio"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text("Recetas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text("Ingredientes"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text("Favoritos"),
        ),
      ],
      //currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      //onTap: _onItemTapped,
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  PlaceholderWidget(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

