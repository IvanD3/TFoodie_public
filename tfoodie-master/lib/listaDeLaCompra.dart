import 'package:flutter/material.dart';
import 'package:tfoodie/datosReceta.dart';
import 'solicitudReceta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tfoodie/pantallaListaDeLaCompra.dart';
import 'solicitudReceta.dart';
import 'prefs.dart';
class tarjetaDeLaCompra with ChangeNotifier{
  String _urlImagen;
  List<String> _listaCompra;
  List<bool>_comprado;
  tarjetaDeLaCompra(DatosReceta dr){
    _urlImagen = dr.imagenURL;
    _listaCompra = new List<String>();
    _listaCompra.addAll(dr.ingredientes.listaString());
    _comprado= new List<bool>.filled(_listaCompra.length,false,growable: true);
  }

  get imagen{
    return _urlImagen;
  }
  get listaCompra{
    return _listaCompra;
  }
  get longitudListaDeLaCompra{
    return _listaCompra.length;
  }
  bool comprado(int indice){
    return _comprado[indice];
  }
  String ingredientes(int indice){
    return _listaCompra[indice];
  }
  void cambiarValor(int indice){
    _comprado[indice] = !_comprado[indice];
  }
}

class listaDeLaCompra with ChangeNotifier{
  List<DatosReceta> _listaRecetas;
  List<tarjetaDeLaCompra> _listaTarjetasDeLaCompra;
  listaDeLaCompra(){
    _listaRecetas = new List<DatosReceta>();
    _listaTarjetasDeLaCompra = new List<tarjetaDeLaCompra>();
    notifyListeners();
  }

  bool existe(DatosReceta dr){
    if(_listaRecetas.contains(dr)){
      print("Existe");
      return true;
    }else{
      print("No existe");
      return false;
    }

  }
  //No tendrá argumento de entrada, usaremos favoritos como placeholder
  Future<bool>generarListaRecetas()async{
    //Aquí irá una petición a cloud
    List<DatosReceta> ldr = await solicitudDatosRecetaMenu();
    _listaRecetas = new List<DatosReceta>();
    _listaTarjetasDeLaCompra = new List<tarjetaDeLaCompra>();
    ldr.forEach((element) {
      _listaRecetas.add(element);
      _listaTarjetasDeLaCompra.add(new tarjetaDeLaCompra(element));
    });
    return true;
  }
  void reset() async{
    _listaRecetas = new List<DatosReceta>();
    _listaTarjetasDeLaCompra = new List<tarjetaDeLaCompra>();
    eliminarRecetas(await getUsuarioFromSharedPreferences());
    notifyListeners();
  }

  void meGustaRecetas(DatosReceta dr)async{
    if(!existe(dr)){
    _listaRecetas.add(dr);
    _listaTarjetasDeLaCompra.add(new tarjetaDeLaCompra(dr));
    agregarReceta(await getUsuarioFromSharedPreferences(), dr.devolverID());
    notifyListeners();}
  }
  get numeroRecetas{
    return _listaTarjetasDeLaCompra.length;
  }
  get listaRecetas{
    return _listaRecetas;
  }
  get listaTarjetasDeLaCompra{
    return _listaTarjetasDeLaCompra;
  }
  tarjetaDeLaCompra receta(int indice){
    return _listaTarjetasDeLaCompra[indice];
  }
  void cambiarValor(int indiceReceta,int indiceIngrediente){
    _listaTarjetasDeLaCompra[indiceReceta].cambiarValor(indiceIngrediente);
    notifyListeners();
  }
}

//Clase creada principalmente para la lista de la compra
/*class listaDeLaCompra with ChangeNotifier{
  List<String> _listaCompra;
  List<DatosReceta> _listaRecetas;
  List<bool>_comprado;
  listaDeLaCompra(){
    _listaCompra = new List<String>();
    _listaRecetas = new List<DatosReceta>();
    _comprado = new List<bool>();
  }

//No tendrá argumento de entrada, usaremos favoritos como placeholder
  Future<bool>generarListaRecetas(List<DatosReceta>ldr)async{
    //Aquí irá una petición a cloud
    _listaRecetas = new List<DatosReceta>();
    _listaCompra = new List<String>();
    ldr.forEach((element) {
      _listaCompra.addAll(element.ingredientes.listaString());
    });
    _comprado= new List<bool>.filled(_listaCompra.length,false,growable: true);
    return true;
  }

  bool meGustaRecetas(DatosReceta dr){
    _listaRecetas.add(dr);
    int longitudLista = _listaCompra.length;
    print(longitudLista);
    _listaCompra.addAll(dr.ingredientes.listaString());
    print(_listaCompra.length.toString()+" - "+longitudLista.toString());
    int longitudDespues = _listaCompra.length - longitudLista;
    for(int i = 0; i < longitudDespues;i++){
      _comprado.add(false);
    }
    print("Longidud de lista: "+_listaCompra.length.toString());
    print("Longidud de comprados: "+_comprado.length.toString());
    notifyListeners();
    return true;
  }
  bool reset(){
    _listaCompra = new List<String>();
    _listaRecetas = new List<DatosReceta>();
    _comprado = new List<bool>();
    notifyListeners();
  }
  get numeroRecetas{
    return _listaRecetas.length;
  }
  get listaRecetas{
    return _listaRecetas;
  }
  get listaCompra{
    return _listaCompra;
  }
  get comprado{
    return _comprado;
  }
  void cambiarValor(index){
    print("Vamos a cambiar el valor de "+index.toString()+" desde "+_comprado[index].toString()+" hasta "+(!_comprado[index]).toString());
    _comprado[index] = !_comprado[index];
    print("Elemento "+index.toString()+" cambiado a "+_comprado[index].toString());
    notifyListeners();
  }
}
*/