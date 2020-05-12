import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:toast/toast.dart';
import 'autentificacion.dart';
class PaginaRegistroLogin extends StatefulWidget{
  PaginaRegistroLogin({this.auth, this.loginCallback});
  final interfazAutentificacion auth;
  final VoidCallback loginCallback;
  _PaginaRegistroLoginState createState()=>new _PaginaRegistroLoginState();
}

class _PaginaRegistroLoginState extends State<PaginaRegistroLogin>{
  String _usuario, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Iniciar sesión"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input.isEmpty)
                  return 'Escribe algo';
              },
              onSaved: (input)=>_usuario = input ,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Correo electrónico"),
            ),
            TextFormField(
              validator: (input){
                if(input.length < 6)
                  return 'Escribe al menos 6 dígitos';
              },
              onSaved: (input)=>_password = input ,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Contraseña",
                  hintText: "Mínimo 6 caracteres"),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                OutlineButton(
                  onPressed: enviar,
                  child: Text("Enviar"),
                ),
                OutlineButton(
                  onPressed: registrar,
                  child: Text("Registrarse"),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<String> enviar() async{
    //print("Usuario:");
    //print(_usuario);
    //print("Contraseña:");
    //print(_password);
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        //await FirebaseAuth.instance.signInWithEmailAndPassword(email: _usuario, password: _password);
        //FirebaseUser usuario = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _usuario, password: _password)).user;
        String userId = await widget.auth.entrar(_usuario, _password,);
        Toast.show("Bienvenido $userId", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        widget.loginCallback();
        //return usuario.uid;
        //Navigator.of(context).pop();
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user: usuario,)));
      }catch(e){
        print('Error: $e');
        setState(() {
          //_isLoading = false;
          //_errorMessage = e.message;
          _formKey.currentState.reset();
      });
    }
  }
  }
  Future<void> registrar() async{
    //print("Usuario:");
    //print(_usuario);
    //print("Contraseña:");
    //print(_password);
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        //await FirebaseAuth.instance.signInWithEmailAndPassword(email: _usuario, password: _password);
        //await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _usuario, password: _password);
        //usuario.sendEmailVerification();
        String userId = await widget.auth.registro(_usuario, _password);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        Toast.show("Registro completado con éxito para $userId", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        //Navigator.of(context).pop();
        //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage(),fullscreenDialog: true));
      }catch(e){
        print(e.messaje);
      }
    }
  }


}


