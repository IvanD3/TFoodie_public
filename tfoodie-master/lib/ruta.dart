
import 'package:flutter/material.dart';
import 'autentificacion.dart';
import 'registroylogin.dart';
import 'home.dart';
import 'favoritos.dart';
import 'package:provider/provider.dart';
import 'prefs.dart';
import 'splashScreen.dart';
//import 'package:flutter_login_demo/pages/login_signup_page.dart';
//import 'package:flutter_login_demo/services/authentication.dart';
//import 'package:flutter_login_demo/pages/home_page.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final interfazAutentificacion auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  @override
  void initState() {
    print("Configuración inicial, estado del servicio: $authStatus");
    super.initState();
    widget.auth.obtenerUsuario().then((user) {
      setState(() {
        if (user != null) {
          print("Usuario es distinto de null");
          _userId = user?.uid;
          print(_userId);
        }
        print("Probando");
        print("Usuario null?");
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.obtenerUsuario().then((user) {

      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Carga de Widget build, estado: $authStatus");
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new PaginaRegistroLogin(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          print("Loading home con $_userId");
          setUsuarioToSharedPreferences(_userId);
          //Mantenemos el provider por compatibilidad, pero para futuro mejor shared prefs
          //Provider.of<favoritos>(context).actualizarUsuario(_userId);
          return new splashScreen(
            user: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}