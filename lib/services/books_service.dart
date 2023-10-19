import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mandaloasinoma_app/models/book.dart'; // Importa tu modelo de Book aquí

class BookService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener todos los books
  // Modificación para obtener todos los libros
  Future<List<Book>> getAllBooks() async {
    try {
      var querySnapshot = await _db.collection('book').get();

      if (querySnapshot.docs.isEmpty) {
        print('No hay libros en la base de datos.');
        return [];
      } else {
        List<Book> books = [];
        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>; // asegurando que los datos son un mapa

          // Añade verificaciones de depuración aquí, por ejemplo, imprimir los datos crudos
          print('Datos crudos del documento: $data');

          try {
            books.add(Book.fromJson(data)); // ahora esto debería ser más seguro
          } catch (e) {
            // Manejo de cualquier error que ocurra durante la conversión
            print('Error al convertir el documento: $e');
            // Puedes optar por continuar y simplemente no añadir este libro, o manejarlo de otra manera
          }
        }
        return books;
      }
    } catch (e) {
      print("Error al obtener libros: $e");
      return [];
    }
  }


  // Obtener books por tipo
  Future<List<Book>> getBooksByType(String type) async {
    try {
      var querySnapshot = await _db
          .collection('book')
          .where('type', isEqualTo: type)
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error al obtener libros por tipo: $e");
      return [];
    }
  }

  // Obtener books por nombre
  Future<List<Book>> getBooksByName(String title) async {
    try {
      // Esto podría no ser óptimo dependiendo de cómo estén configurados tus índices y la cantidad de datos.
      // Firestore no admite consultas 'LIKE', considera usar una función de búsqueda de texto completo.
      var querySnapshot = await _db
          .collection('book')
          .where('title', isEqualTo: title)
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error al obtener libros por nombre: $e");
      return [];
    }
  }

  // Obtener books por género
  Future<List<Book>> getBooksByGenre(String genre) async {
    try {
      // Esta consulta asume que 'genders' es un array en Firestore
      var querySnapshot = await _db
          .collection('book')
          .where('genders', arrayContains: genre)
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener libros por género: $e");
      return [];
    }
  }

  // Obtener books por autor
  Future<List<Book>> getBooksByAuthor(String author) async {
    try {
      var querySnapshot = await _db
          .collection('book')
          .where('author', isEqualTo: author)
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener libros por autor: $e");
      return [];
    }
  }

  // Obtener los libros más populares
  Future<List<Book>> getMostPopularBooks() async {
    try {
      var querySnapshot = await _db
          .collection('book')
          .orderBy('visits', descending: true) // asume que "visits" es un campo en tu documento
          .limit(10) // obtener, por ejemplo, los top 10
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener los libros más populares: $e");
      return [];
    }
  }

  // Obtener los libros más recientes
  Future<List<Book>> getMostRecentBooks() async {
    try {
      var querySnapshot = await _db
          .collection('book')
          .orderBy('publicationDate', descending: true) // asume que "added_on" es un campo de fecha/timestamp
          .limit(10) // por ejemplo, los últimos 10 libros añadidos
          .get();
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener los libros más recientes: $e");
      return [];
    }
  }

  // Obtener libros que se lanzarán en el futuro (próximamente)
  Future<List<Book>> getComingSoonBooks() async {
    try {
      // Obtiene la fecha y hora actuales
      DateTime now = DateTime.now();

      // Realiza una consulta para obtener libros cuya fecha de adición está en el futuro
      var querySnapshot = await _db
          .collection('book')
          .where('publicationDate', isGreaterThan: now)
          .get();

      // Mapea los documentos obtenidos a objetos de libro
      return querySnapshot.docs
          .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener los libros 'próximamente': $e");
      return [];
    }
  }

}
