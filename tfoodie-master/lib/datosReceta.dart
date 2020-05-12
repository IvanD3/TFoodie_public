//Clase para modular la lista de ingredientes
import 'dart:math';

class Ingredientes{
  List<dynamic> ingredientes;
  Ingredientes({
    this.ingredientes}
      );
  factory Ingredientes.fromJson(Map parsedJson){
    return Ingredientes(
        ingredientes:parsedJson['_ingredientes']
    );
  }
  factory Ingredientes.fromMap(Map data){
    return Ingredientes(
      ingredientes: data['_ingredientes']
    );
  }
  int longitud(){
    return ingredientes.length;
  }
  String texto(int index){
    if(ingredientes[index].length==1){
      return ingredientes[index][0].toString();
    }else{
      return ingredientes[index][0].toString()+": "+ingredientes[index][1].toString();
    }
  }
  //Método que devuelve la lista de ingredientes como strings
  List<String> listaString(){
    List<String> l = List<String>();
    var longitud = this.longitud();
    for(int i = 0; i <longitud;i++){
      l.add(this.texto(i));
    }
    return l;
  }
  //Método que devuelve la lista de ingredientes como Map
  Map<String,dynamic>toMap() {
    print("Vamos a crear el map");
    Map<String,dynamic> ingredientesMap = Map<String,dynamic>();
    var longitud = this.longitud();
    for(int i = 0; i <longitud;i++){
      if(ingredientes[i].length==2){
      ingredientesMap[ingredientes[i][0]]=ingredientes[i][1];}else{
        ingredientesMap[ingredientes[i][0]]=" ";
      }
    }
    //var ingredientesMap = Map.fromIterable(ingredientes,key:(e)=>ingredientes[e][0],value: (e)=>ingredientes[e][1]);
    //print(ingredientesMap);
  return ingredientesMap;
  }
}
//Clase que modula la información contenida por una receta
//Tenemos el id de la base de datos, el nombre de la receta, direccion de la receta e imagen y lista de ingredientes
//Se construye a través de un json

class DatosReceta {
  Map<String,dynamic> id;
  //String id;
  String  nombre,
      recetaURL,
      imagenURL;
  Ingredientes ingredientes;
  DatosReceta({this.id,
    this.nombre,
    this.recetaURL,
    this.imagenURL,
    this.ingredientes}
      );
  factory DatosReceta.fromJson(Map parsedJson){
    return DatosReceta(
        id       :parsedJson['_id'],
        nombre   :parsedJson['_nombre'],
        recetaURL:parsedJson['_recetaURL'],
        imagenURL:parsedJson['_imagenURL'],
        ingredientes:new Ingredientes.fromJson(parsedJson)
    );
  }
  factory DatosReceta.fromMap(Map data){
    return DatosReceta(
        id       :data['_id'],
        nombre   :data['_nombre'],
        recetaURL:data['_recetaURL'],
        imagenURL:data['_imagenURL'],
        ingredientes:new Ingredientes.fromMap(data)
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'nombre' : nombre,
      'recetaURL' : recetaURL,
      'imagenURL' : imagenURL,
      'ingredientes': ingredientes.toMap(),
    };
  }
  String devolverID(){
    String idFormatoTexto = id.toString();
    return idFormatoTexto;
  }
}

