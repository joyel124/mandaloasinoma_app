import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/book.dart';
import '../views/book_detail_view.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetail(
                  book: book,
                ),
              ),
            );
          },
          child: Container(
            height: 190,
            width: 128,
            margin: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                book.coverImg,
                fit: BoxFit.cover,
                width: 128,
                height: 190,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;  // Si `loadingProgress` es null, significa que la imagen se cargó correctamente.
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      // Aquí puedes manejar la lógica del valor actual del progreso, si quieres que sea determinado.
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // Maneja cualquier error ocurrido durante la carga de la imagen.
                  return const Center(child: Text('Error al cargar la imagen'));
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 128,
            child: Text(
              book.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: theme.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
