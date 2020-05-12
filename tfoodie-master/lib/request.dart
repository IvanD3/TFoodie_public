//import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
import 'datosReceta.dart';

Future<DatosReceta> requestDatosReceta(URL) async{
  var response = await http.get(URL);
  print('Response status: ${response.statusCode}');
  final recetaEnBruto = response.body;
  print("Allá vamos con la receta sin codificar");
  //print("Longitud de la lista: ");
  print(recetaEnBruto);
  //print(recetaEnBruto)
  print("Hora de decodificar");
  Map<String,dynamic> jsonResponse = jsonDecode(recetaEnBruto);
  print("Decodificame esta");

  print(jsonResponse.runtimeType);
  /*
  print(jsonResponse['_id'].runtimeType);
  print(jsonResponse['_nombre'].runtimeType);
  print(jsonResponse['_recetaURL'].runtimeType);
  print(jsonResponse['_imagenURL'].runtimeType);
  print(jsonResponse['_ingredientes'].runtimeType);
  */
//ESTAMOS AQUI, TRABAJANDO CON EL JSON
  print("Y ahora tras la codificación");
  DatosReceta dr = new DatosReceta.fromJson(jsonDecode(recetaEnBruto));
  print(dr.nombre);
  print(dr.imagenURL);
  print(dr.recetaURL);
  print(dr.ingredientes);
  print(dr.ingredientes.longitud());

  print("Y ahora voy a imprimir el map");
  print(dr.toMap());
  /*for(int i=0;i<receta.length;i++){
    print("Vampos por la receta número "+(i+1).toString());
    print(receta[i]);
  }*/


  //print(await http.read(URL));

  return Future.value(dr);
}

Future<void> fetchUserOrder(String URL) {
  // Imagine that this function is fetching user info from another service or database
  return Future.delayed(Duration(seconds: 3), () => print('Conexión establecida con $URL'));
}
Future<void> main() async {

  String URL = 'https://europe-west1-tfoodie.cloudfunctions.net/randomDB-1';
  print("Pos vamo a hacer el trycatch ese no?");
  try {
    await requestDatosReceta(URL);
    //await fetchUserOrder(URL);
  } catch (err) {
    print('Caught error: $err');
  }


  print("Y que más quieres máquina");
}
