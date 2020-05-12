import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfoodie/datosReceta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'solicitudReceta.dart';
import 'prefs.dart';
//Clase inicialmente creada para favoritos, pero que gestiona toda la lógica
class favoritos with ChangeNotifier{

  List<DatosReceta> _recetasFavoritas;

  favoritos(){
    if(_recetasFavoritas == null)
      _recetasFavoritas = new List<DatosReceta>();
  }
  Future<bool> cargarRecetasFavoritas()async{
    _recetasFavoritas = await solicitudDatosRecetafavoritos();
    return true;
  }
  /*actualizarUsuario(String user){
    this._user = user;
    print("Usuario actualizado con id "+user);
    //notifyListeners();
  }
  get user{
    return _user;
  }*/
  get recetasFavoritas{
    return _recetasFavoritas;
  }
  void agregar(DatosReceta nuevaReceta)async {
    if(!existe(nuevaReceta)){
      _recetasFavoritas.add(nuevaReceta);
      agregarFavoritos(await getUsuarioFromSharedPreferences(), nuevaReceta.devolverID());
      notifyListeners();
    }

  }
  bool existe(DatosReceta dr){
    if(_recetasFavoritas.contains(dr)){
      print("Existe");
      return true;
    }else{
      print("No existe");
      return false;
    }

  }
  void eliminar(DatosReceta eliminar) async{
    _recetasFavoritas.remove(eliminar);
    eliminarFavoritos(await getUsuarioFromSharedPreferences(), eliminar.devolverID());
    //notifyListeners();
  }
}
