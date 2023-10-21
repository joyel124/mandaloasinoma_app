import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Solicitar permisos para iOS.
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Usuario aceptó permisos de notificación');
    } else {
      print('Permisos de notificación denegados');
    }

    // Manejo de mensajes en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensaje recibido en primer plano: ${message.notification?.body}');
      // Aquí podrías manejar cómo se mostrarán estas notificaciones
    });

    // Código adicional para manejar notificaciones cuando la aplicación está en segundo plano o terminada podría ir aquí.
  }
}
