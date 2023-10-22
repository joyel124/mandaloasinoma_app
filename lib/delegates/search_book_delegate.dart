import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/book.dart';
import '../services/books_service.dart';
import '../widgets/book_item_widget.dart';

class SearchBookDelegate extends SearchDelegate {
  // Lista de ejemplo de libros, reemplaza esto con tu lista de datos o lógica para obtener datos.
  final bookService = BookService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // No es necesario cerrar la búsqueda cuando se limpia la consulta.
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), // Cerrar la búsqueda y volver.
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder<List<Book>>(
        future: bookService
            .getBooksByName(query), // este método ahora debe devolver List<Book>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Si estamos esperando los resultados, muestra un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // En caso de error, muestra un mensaje al usuario
            return Center(child: Text('Ha ocurrido un error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Si la consulta está completa, pero no hay datos (lo que significa que no se encontraron libros),
            // muestra un mensaje.
            return const Center(
                child: Text('No se encontraron libros con ese título'));
          } else {
            // Si hay libros, los mostramos en un grid
            List<Book> books = snapshot.data!; // tenemos una lista de libros aquí

            return Padding(
              padding: const EdgeInsets.only(top: 16, left:16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // número de columnas
                  crossAxisSpacing: 0, // espacio entre las celdas
                  mainAxisSpacing: 0, // espacio entre las filas
                  childAspectRatio:
                      0.6, // relación entre el ancho y el alto de las celdas
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  // 'BookItem' es tu widget que acepta un libro y muestra la información adecuada
                  return BookItem(book: books[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen mientras el usuario escribe
    return Container();
  }
}
