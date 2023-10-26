import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/author.dart';

class AuthorService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<List<Author>> getAllAuthors() async {
    try {
      var snapshot = await _db.collection('authors').get();
      return snapshot.docs.map((doc) => Author.fromJSON(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      // maneja la excepción, por ejemplo, imprimir en consola o mostrar un diálogo de error
      print("Error al obtener autores: $e");
      return [];
    }
  }
}