import 'package:flutter/material.dart';
import 'package:tfoodie/datosReceta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'solicitudReceta.dart';
//Clase inicialmente creada para favoritos, pero que gestiona toda la lógica
class bufferDeRecetas with ChangeNotifier{
  List<DatosReceta> _recetasBuffer;
  bufferDeRecetas(){
    if(_recetasBuffer == null)
      _recetasBuffer = new List<DatosReceta>();
  }

  Future<bool> cargarBuffer()async{
    _recetasBuffer = await solicitudDatosReceta();
    return true;
  }
  get recetasBuffer{
    return _recetasBuffer;
  }
  void reemplazar() async{
    _recetasBuffer = await solicitudDatosReceta();
      notifyListeners();
  }
  DatosReceta pop(){
    DatosReceta dr = _recetasBuffer[0];
    _recetasBuffer.removeAt(0);
    if(_recetasBuffer.length < 10)
      reemplazar();
    notifyListeners();
    return dr;
  }
  DatosReceta frente(){
    return _recetasBuffer[0];
  }
}
