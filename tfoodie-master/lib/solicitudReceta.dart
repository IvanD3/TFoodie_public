import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'datosReceta.dart';
import 'dart:convert';
import 'dart:io';
import 'favoritos.dart';
import 'package:provider/provider.dart';
import 'prefs.dart';
//Método solicitudDatosReceta
//Método asíncrono que devuelve una lista de 30 recetas

Future<List<DatosReceta>> solicitudDatosReceta() async{
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/randomDB-30-st';
  var response = await http.get(URL);
  print("Vamos a probar la request");
  print('Response status: ${response.statusCode}');
  if(response.statusCode == 200) {
    final recetaEnBruto = response.body;
    final jsonResponse = jsonDecode(recetaEnBruto);
    List<DatosReceta> ldr = new List<DatosReceta>();
    //print("Vamos a probar");
    for (int i = 0; i < jsonResponse.length; i++) {
      //print("Probando receta número: "+i.toString());
      ldr.add(new DatosReceta.fromJson(jsonDecode(jsonResponse[i])));
      //print("Receta creada: "+i.toString());
    }
    return Future.value(ldr);
  }else{
    //print("Error: solicitud fallida");
    throw new Exception("Error: solicitud fallida");
  }
  await new Future.delayed(new Duration(seconds: 5));
  return new List<DatosReceta>();
}

Future<List<DatosReceta>> solicitudDatosRecetafavoritos() async{
  print("Vamos a probar la request del usuario");
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/leer-recetas-usuario';
  String user = await getUsuarioFromSharedPreferences();
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : user,
    }),
  );
  print('Response status: ${response.statusCode}');
  if(response.statusCode == 200) {
    final recetaEnBruto = response.body;
    final jsonResponse = jsonDecode(recetaEnBruto);
    List<DatosReceta> ldr = new List<DatosReceta>();
    //print("Vamos a probar");
    for (int i = 0; i < jsonResponse.length; i++) {
      //print("Probando receta número: "+i.toString());
      ldr.add(new DatosReceta.fromJson(jsonDecode(jsonResponse[i])));
      //print("Receta creada: "+i.toString());
    }
    return Future.value(ldr);
  }else{
    //print("Error: solicitud fallida");
    throw new Exception("Error: solicitud fallida");
  }
  await new Future.delayed(new Duration(seconds: 5));
  return new List<DatosReceta>();
}

Future<void> agregarFavoritos(idUsuario,idReceta) async{
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/add-recetas-favoritos-1';
  print("{_idUsuario : "+ idUsuario+", _idReceta : "+idReceta);
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : idUsuario,
      '_idReceta':idReceta,
    }),
  );
  if(response.statusCode == 200) {
    print("Receta añadida con éxito");
  }else{
    throw new Exception("Error: solicitud fallida");
  }
}



Future<void> eliminarFavoritos(idUsuario,idReceta) async{
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/delete-recetas-favoritos';
  print("{_idUsuario : "+ idUsuario+", _idReceta : "+idReceta);
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : idUsuario,
      '_idReceta':idReceta,
    }),
  );
  if(response.statusCode == 200) {
    print("Receta añadida con éxito");
  }else{
    throw new Exception("Error: solicitud fallida");
  }
}
Future<List<DatosReceta>> solicitudDatosRecetaMenu() async{
  //String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/randomDB-30-st';
  //var response = await http.get(URL);
  print("Vamos a probar la request del usuario");
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/leer-lista-recetas-usuario';
  String user = await getUsuarioFromSharedPreferences();
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : user,
    }),
  );
  print('Response status: ${response.statusCode}');
  if(response.statusCode == 200) {
    final recetaEnBruto = response.body;
    final jsonResponse = jsonDecode(recetaEnBruto);
    List<DatosReceta> ldr = new List<DatosReceta>();
    //print("Vamos a probar");
    for (int i = 0; i < jsonResponse.length; i++) {
      //print("Probando receta número: "+i.toString());
      ldr.add(new DatosReceta.fromJson(jsonDecode(jsonResponse[i])));
      //print("Receta creada: "+i.toString());
    }
    return Future.value(ldr);
  }else{
    //print("Error: solicitud fallida");
    throw new Exception("Error: solicitud fallida");
  }
  await new Future.delayed(new Duration(seconds: 5));
  return new List<DatosReceta>();
}

Future<void> agregarReceta(idUsuario,idReceta) async{
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/add-recetas-lista';
  //print("{_idUsuario : "+ idUsuario+", _idReceta : "+idReceta);
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : idUsuario,
      '_idReceta':idReceta,
    }),
  );
  if(response.statusCode == 200) {
    print("Receta añadida con éxito");
  }else{
    throw new Exception("Error: solicitud fallida");
  }
}



Future<void> eliminarRecetas(idUsuario) async{
  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/delete-lista-recetas-usuario';
  print("{_idUsuario : "+ idUsuario);
  var response = await http.post(
    URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_idUsuario' : idUsuario,
    }),
  );
  if(response.statusCode == 200) {
    print("Receta añadida con éxito");
  }else{
    throw new Exception("Error: solicitud fallida");
  }
}

