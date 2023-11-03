import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/content_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializa el servicio de notificaciones
  //await PushNotificationService.initializeApp();
  //getToken();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContenidoProvider>(
      create: (context) => ContenidoProvider(),
      child: MaterialApp(
        title: 'MandaloAsiNoma App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: SplashRoute,
        routes: getApplicationRoutes(),
      ),
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
