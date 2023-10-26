import 'package:flutter/material.dart';
import '../data/data.dart';

class CircleItem extends StatelessWidget {
  final String name;
  final String iconPath;

  CircleItem({required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(// espacio alrededor del ícono; puedes ajustar esto según la apariencia deseada
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor, // o cualquier otro color que prefieras
          ),
          child: ClipOval( // <-- ClipOval es utilizado aquí para mantener la forma circular de la imagen.
            child: Image.network(
              iconPath,
              width: 70, // define un tamaño adecuado; el contenedor es un poco más grande debido al padding
              height: 70,
              fit: BoxFit.cover, // esto hará que la imagen cubra el contenedor respetando la proporción de la imagen
            ),
          ),
        ),
        SizedBox(height: 8), // espacio entre el ícono y el texto
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: theme.textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
