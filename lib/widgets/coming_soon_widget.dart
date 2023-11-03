import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';

import '../models/book.dart';
import '../services/books_service.dart';
import 'book_item_widget.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookService = BookService();
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinea los elementos a la izquierda.
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Próximamente',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: theme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<Book>>(
          future: bookService
              .getComingSoonBooks(), // La llamada al método que recupera los libros de Firebase.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Proporcionar un indicador de carga mientras esperamos.
              return Center(child: CircularProgressIndicator(
                color: theme.accentColor,
              ));
            } else if (snapshot.hasError) {
              // Manejo de errores.
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Manejar el caso de no datos.
              return Center(
                child: Text(
                    'No hay mangas proximamente',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: theme.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                ),
              );
            } else {
              // Los datos están disponibles, construir la lista.
              List<Book> books = snapshot.data!;
              int maxBooksToShow = 5;
              books = (books.length > maxBooksToShow) ? books.sublist(0, maxBooksToShow) : books;
              return SizedBox(
                height: 216,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    var book = books[index];
                    return BookItem(book: book);
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(height: 94),
      ],
    );
  }
}
