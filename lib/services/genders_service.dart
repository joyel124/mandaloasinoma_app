import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/gender.dart';

class GenderService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Recuperar todos los géneros de la colección 'genders'
  Future<List<Gender>> getAllGenres() async {
    try {
      var snapshot = await _db.collection('genders').get();
      return snapshot.docs.map((doc) => Gender.fromJSON(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      // maneja la excepción, por ejemplo, imprimir en consola o mostrar un diálogo de error
      print("Error al obtener géneros: $e");
      return [];
    }
  }
}