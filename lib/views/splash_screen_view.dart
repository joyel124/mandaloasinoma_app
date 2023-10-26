import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/views/home_view.dart';

class Splash extends StatefulWidget {

  const Splash({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Inicia el temporizador que cambia a tu nueva pantalla después de 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(), // reemplaza 'NextScreen' con el nombre de tu pantalla principal
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff171717),
              Color(0xffDA0037),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/img/descarga.png',  // referencia al archivo de imagen que colocaste en la carpeta assets
            width: 150,  // opcional, para definir un ancho específico
            height: 150,  // opcional, para definir una altura específica
            fit: BoxFit.contain,  // opcional, para manejar cómo tu imagen debería ocupar el espacio asignado
          ),
        ),
      ),
    );
  }
}
