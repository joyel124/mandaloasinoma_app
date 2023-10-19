import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

class MyFirestoreTestPage extends StatelessWidget {
  // Esta función se conecta a Firestore y obtiene un documento específico.
  void getAllBooksFromFirestore() {
    FirebaseFirestore.instance
        .collection('book')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // Verifica si hay documentos en la consulta
      if (querySnapshot.docs.isEmpty) {
        print('No hay libros en la base de datos.');
      } else {
        // Itera sobre todos los documentos obtenidos
        for (var doc in querySnapshot.docs) {
          // Imprime los datos de cada libro/documento
          print('Datos del libro: ${doc.data()}');
        }
      }
    }).catchError((error) {
      print("Hubo un error al obtener los libros: $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Firestore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Llama a la función cuando se presiona el botón.
            getAllBooksFromFirestore();
          },
          child: Text('Obtener datos de Firestore'),
        ),
      ),
    );
  }
}
