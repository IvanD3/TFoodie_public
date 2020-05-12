import 'package:shared_preferences/shared_preferences.dart';

Future<String>getUsuarioFromSharedPreferences()async{
  final preferencias = await SharedPreferences.getInstance();
  final usuario = preferencias.getString('user');
  if(usuario!= null){
    return usuario;
  }
}
Future<void>setUsuarioToSharedPreferences(String user)async{
  final preferencias = await SharedPreferences.getInstance();
  final usuario = preferencias.setString('user',user);
}
//Método para extraer información del número de recetas semanales
//Si hay un valor guardado devolverá dicho valor. En caso contrario, devolverá 5 como valor por defecto
Future<int>getRecetasFromSharedPreferences()async{
  final preferencias = await SharedPreferences.getInstance();
  final recetas = preferencias.getInt('menuSemanal');
  if(recetas!= null){
    return recetas;
  }else{
    return 5;
  }
}
Future<void>setRecetasToSharedPreferences(int recetas)async{
  final preferencias = await SharedPreferences.getInstance();
  final usuario = preferencias.setInt('menuSemanal',recetas);
}
