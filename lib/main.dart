import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import 'package:mandaloasinoma_app/services/notification_service.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializa el servicio de notificaciones
  PushNotificationService().initialize();
  getToken();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MandaloAsiNoma App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: HomeRoute,
      routes: getApplicationRoutes(),
    );
  }
}

void getToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  print("Este es tu Token: $token");

  // Para propósitos de prueba, podrías mostrar el token en la pantalla
  // para copiarlo fácilmente. O puedes enviarlo a tu base de datos o servidor si es necesario.
}
