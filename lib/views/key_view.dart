import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:provider/provider.dart';
import 'package:mandaloasinoma_app/models/content_provider.dart'; // Ajusta la ruta según la estructura de tu proyecto

class KeyView extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme.textColor, // elige el color que desees para el ícono
        ),
        backgroundColor: theme.backgroundColor,
        title: Text("Ingresar Palabra Clave",
          style: TextStyle(
            fontFamily: 'Oswald',
            color: theme.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          )
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: _controller,
                obscureText: true, // Esto es para ocultar el texto ingresado, similar a una contraseña.
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.textColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.accentColor),
                  ),
                  labelText: 'Ingresa la palabra clave',
                  hintText: 'Palabra clave',
                  labelStyle: TextStyle(
                    color: theme.textColor,  // Color del labelText.
                    fontSize: 18.0,      // Tamaño de letra del labelText.
                    fontWeight: FontWeight.bold, // Peso de la letra del labelText.
                  ),
                  hintStyle: TextStyle(
                    color: theme.textColor,  // Color del hintText.
                    fontSize: 18.0,      // Tamaño de letra del hintText.
                  ),
                  contentPadding: EdgeInsets.only(top: 0),
                ),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(theme.accentColor),
              ),
              child: const Text("Desbloquear",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )
              ),
              onPressed: () {
                final clave = _controller.text;
                final contenidoProvider = Provider.of<ContenidoProvider>(context, listen: false);
                contenidoProvider.desbloquearContenido(clave);

                // Opcionalmente, puedes navegar a otra página o mostrar un mensaje si la clave es correcta.
                if (contenidoProvider.contenidoDesbloqueado) {
                  Navigator.of(context).pop(); // Vuelve a la página anterior o navega a donde desees.
                } else {
                  // Muestra un mensaje de error o alerta
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("Palabra clave incorrecta!, puedes encontrar la palabra clave en nuestras redes sociales."),
                    backgroundColor: theme.accentColor,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
