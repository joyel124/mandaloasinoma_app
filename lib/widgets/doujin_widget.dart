import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/widgets/book_item_widget.dart';
import '../models/book.dart';
import '../services/books_service.dart';

class DoujinsSection extends StatelessWidget {
  const DoujinsSection({Key? key}) : super(key: key);

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
                'Doujins',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: theme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Ver más',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<Book>>(
          future: bookService
              .getBooksByType("doujin"), // La llamada al método que recupera los libros de Firebase.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Proporcionar un indicador de carga mientras esperamos.
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Manejo de errores.
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Manejar el caso de no datos.
              return const Center(child: Text('No hay libros disponibles'));
            } else {
              // Los datos están disponibles, construir la lista.
              List<Book> books = snapshot.data!;

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
      ],
    );
  }
}
