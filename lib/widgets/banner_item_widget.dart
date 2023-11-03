import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';
import '../models/book.dart';
import '../models/content_provider.dart';
import '../views/book_detail_view.dart';
import '../views/key_view.dart';

class BannerItemBook extends StatelessWidget {
  final Book book;
  const BannerItemBook({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contenidoProvider = Provider.of<ContenidoProvider>(context, listen: true);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => contenidoProvider.contenidoDesbloqueado?BookDetail(book: book): KeyView(),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: book.title,
            child: Container(
              height: 200,
              width: 296,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // La imagen ahora se cargará con un widget, en lugar de con DecorationImage.
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: contenidoProvider.contenidoDesbloqueado?Image.network(
                  book.coverImg,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;  // Si no hay progreso, la imagen se cargó correctamente.
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.accentColor,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Error al cargar la imagen'));
                  },
                ):
                const Image(image: AssetImage('assets/img/placeholder-app.jpg'), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    book.title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: theme.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/watch.svg'),
                        const SizedBox(width: 4),
                        Text(
                          '${book.visits}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: theme.textColor,
                            fontSize: 12,
                            height: 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
