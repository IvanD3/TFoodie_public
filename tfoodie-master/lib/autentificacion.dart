import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class interfazAutentificacion {
  Future<String> entrar(String email, String password);
  Future<String> registro(String email, String password);
  Future<FirebaseUser> obtenerUsuario();
  Future<void> salir();
  Future<void> enviarEmailVerificacion();
  Future<bool> emailVerificado();
}

class autentificacion implements interfazAutentificacion {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> entrar(String email, String password) async {
    print("Hora de hacer login");
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> registro(String email, String password) async {
    print("Hora de realizar el registro");
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> obtenerUsuario() async {
    print("Vamos a obtener el usuario");
    //El signout está por propósitos temporales
    //_firebaseAuth.signOut();
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> salir() async {
    print("Vamos a realizar logout");
    return _firebaseAuth.signOut();
  }

  Future<void> enviarEmailVerificacion() async {
    print("Enviar usuario de verificacion");
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> emailVerificado() async {
    print("¿Está el usuario verificado? Vamos a comprobarlo");
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}