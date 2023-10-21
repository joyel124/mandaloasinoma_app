import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';
import '../models/book.dart';
import '../services/books_service.dart';
import '../views/book_detail_view.dart';
import 'banner_item_widget.dart';

class MostPopularSection extends StatelessWidget{
  const MostPopularSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final bookService = BookService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Más Populares',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Oswald',
              color: theme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<Book>>(
          future: bookService
              .getMostPopularBooks(), // La llamada al método que recupera los libros de Firebase.
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
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: ((context, index) {
                    return BannerItemBook(book: books[index]);
                  }),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}