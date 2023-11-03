import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContenidoProvider with ChangeNotifier {
  bool _contenidoDesbloqueado = false;

  ContenidoProvider() {
    _loadContenidoDesbloqueado();
  }

  bool get contenidoDesbloqueado => _contenidoDesbloqueado;

  _loadContenidoDesbloqueado() async {
    final prefs = await SharedPreferences.getInstance();
    _contenidoDesbloqueado = prefs.getBool('contenidoDesbloqueado') ?? false;
  }

  _saveContenidoDesbloqueado() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('contenidoDesbloqueado', _contenidoDesbloqueado);
  }

  void desbloquearContenido(String clave) {
    if (clave == "MAN FanSub") {
      _contenidoDesbloqueado = true;
      _saveContenidoDesbloqueado();
      notifyListeners();
    }
  }
}