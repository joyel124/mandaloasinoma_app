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

  // Obtener book por nombre
  Future<Book?> getBookByName(String title) async {
    try {
      // Realizando la consulta a la base de datos
      var querySnapshot = await _db
          .collection('book') // Asegúrate de que 'books' sea el nombre correcto de tu colección
          .where('title', isGreaterThanOrEqualTo: title)
          .limit(1) // Limitamos la consulta a un solo documento
          .get();

      // Verificar si encontramos al menos un libro
      if (querySnapshot.docs.isNotEmpty) {
        // Si encontramos un libro, lo devolvemos
        return Book.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        // Si no hay resultados, devolvemos null
        return null;
      }
    } catch (e) {
      // Manejo de cualquier error que pueda ocurrir durante la consulta
      print("Error al obtener el libro por nombre: $e");
      return null; // Podrías manejar esto de manera diferente, según tus necesidades
    }
  }

  Future<List<Book>> getBooksByName(String title) async {
    List<Book> bookList = [];
    var endTitle = title.substring(0, title.length - 1) + String.fromCharCode(title.codeUnitAt(title.length - 1) + 1);
    try {
      // Realizando la consulta a la base de datos
      var querySnapshot = await _db
          .collection('book') // Asegúrate de que 'books' sea el nombre correcto de tu colección
          .where('title', isGreaterThanOrEqualTo: title)
      // Aquí no limitamos la consulta, porque queremos obtener todas las coincidencias
          .where('title', isLessThan: endTitle)
          .get();

      // Construir la lista de libros basada en la consulta
      for (var doc in querySnapshot.docs) {
        bookList.add(Book.fromJson(doc.data() as Map<String, dynamic>));
      }

      return bookList;
    } catch (e) {
      // Manejo de cualquier error que pueda ocurrir durante la consulta
      print("Error al obtener los libros por nombre: $e");
      return []; // Devolver una lista vacía en caso de error
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
          .limit(4) // obtener, por ejemplo, los top 10
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

  Future<void> incrementViewCount(String bookId) async {
    try {
      DocumentReference mangaRef = _db.collection('book').doc(bookId);

      await _db.runTransaction((Transaction transaction) async {
        DocumentSnapshot snapshot = await transaction.get(mangaRef);

        if (!snapshot.exists) {
          throw Exception("Document does not exist!");
        }

        int newViews = (snapshot.data() as Map<String, dynamic>)['visits'] + 1;
        transaction.update(mangaRef, {'visits': newViews});
      });
    } catch (e) {
      print("Error al incrementar el contador de vistas: $e");
    }
  }


}
