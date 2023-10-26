import 'package:flutter/cupertino.dart';
import 'package:mandaloasinoma_app/views/home_view.dart';
import 'package:mandaloasinoma_app/views/favorites_view.dart';
import 'package:mandaloasinoma_app/views/explorer_view.dart';

import '../views/splash_screen_view.dart';

// Esta es una buena práctica para evitar errores tipográficos en los nombres de las rutas
const String SplashRoute = '/';
const String HomeRoute = '/home';
const String FavoritesRoute = '/favorites';
const String ExplorerRoute = '/explorer';

// Puedes crear una función que devuelva tus rutas mapeadas
Map<String, WidgetBuilder> getApplicationRoutes() {
  return {
    SplashRoute: (context) =>  Splash(),
    HomeRoute: (context) => Home(),
    FavoritesRoute: (context) => Favorites(),
    ExplorerRoute: (context) => Explorer(),
    // Agrega más rutas aquí
  };
}
