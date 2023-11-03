import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';
import '../models/content_provider.dart';

class CircleItem extends StatelessWidget {
  final String name;
  final String iconPath;

  CircleItem({required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    final contenidoProvider = Provider.of<ContenidoProvider>(context, listen: true);
    return Column(
      children: [
        Container(// espacio alrededor del ícono; puedes ajustar esto según la apariencia deseada
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor, // o cualquier otro color que prefieras
          ),
          child: ClipOval( // <-- ClipOval es utilizado aquí para mantener la forma circular de la imagen.
            child: contenidoProvider.contenidoDesbloqueado?Image.network(
              iconPath,
              width: 70, // define un tamaño adecuado; el contenedor es un poco más grande debido al padding
              height: 70,
              fit: BoxFit.cover, // esto hará que la imagen cubra el contenedor respetando la proporción de la imagen
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;  // Si `loadingProgress` es null, significa que la imagen se cargó correctamente.
                }
                return Center(
                  child: SizedBox(  // <--- Usamos SizedBox aquí
                    width: 35,    // Define el tamaño que quieres para el CircularProgressIndicator
                    height: 35,
                    child: CircularProgressIndicator(
                      color: theme.accentColor,
                    ),
                  ),
                );
              },
            ):
            const Image(
                width: 70,
                height: 70,
                image: AssetImage('assets/img/placeholder-app.jpg'),
                fit: BoxFit.cover
            ),
          ),
        ),
        SizedBox(height: 8), // espacio entre el ícono y el texto
        contenidoProvider.contenidoDesbloqueado?Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: theme.textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ):
        Text(
          'Bloqueado',
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
