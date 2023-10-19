// lib/screens/favorite_screen.dart
import 'package:flutter/material.dart';

import '../data/data.dart';

class Favorites extends StatelessWidget {
  // Esta lista es solo para demostración. En una aplicación real, estos datos vendrían de tu estado o base de datos.
  final List<String> favoriteItems = [
    'Manga 1',
    'Manga 2',
    'Doujin 1',
    // Agrega más elementos de prueba si lo deseas
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: TextStyle(
            fontFamily: 'Oswald',
            color: theme.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        // Si quieres, puedes hacer que la AppBar sea transparente para un diseño más moderno
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return FavoriteItemCard(itemTitle: favoriteItems[index]);
        },
      ),
    );
  }
}

// Puedes incluir este widget en el mismo archivo o en uno separado.
class FavoriteItemCard extends StatelessWidget {
  final String itemTitle;

  const FavoriteItemCard({Key? key, required this.itemTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8), // Espaciado alrededor de cada tarjeta
      elevation: 5, // Sombra alrededor de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 20), // Espaciado interno
        title: Text(
          itemTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.favorite, // Icono del corazón
          color: Colors.red, // Color rojo para el corazón
          size: 24, // Tamaño del icono
        ),
        onTap: () {
          // Acción cuando se toca la tarjeta
          // Por ejemplo, podrías abrir la pantalla de detalles del manga o doujin
        },
      ),
    );
  }
}
