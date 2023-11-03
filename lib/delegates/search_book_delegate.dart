import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/book.dart';
import '../services/books_service.dart';
import '../views/book_detail_view.dart';

enum SearchType {
  author,
  name,
  genre,
  type,
}

class SearchBookDelegate extends SearchDelegate {
  // Lista de ejemplo de libros, reemplaza esto con tu lista de datos o lógica para obtener datos.
  final bookService = BookService();
  late final SearchType searchType; // El tipo de búsqueda que se va a realizar.
  late final String searchTerm; // El término de búsqueda, por ejemplo, un autor específico.

  SearchBookDelegate(this.searchType);

  @override
  String? get searchFieldLabel => "Buscar...";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData tema = Theme.of(context);
    return tema.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.backgroundColor,
        iconTheme: tema.primaryIconTheme.copyWith(color: theme.textColor),
        titleTextStyle: tema.textTheme.titleLarge,
        toolbarTextStyle: tema.textTheme.bodyMedium,
      ),
      textTheme: TextTheme(
        // Use this to change the query's text style
        titleLarge: TextStyle(
          color: theme.textColor,
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: TextStyle(
              color: theme.textColor,
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
          ),
    );
  }

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
    // El FutureBuilder ahora deberá seleccionar el método de búsqueda adecuado en base al searchType
    Future<List<Book>> Function(String) searchFunction;

    switch (searchType) {
      case SearchType.author:
        searchFunction = bookService.getBooksByAuthor;
        break;
      case SearchType.genre:
        searchFunction = bookService.getBooksByGenre;
        break;
      case SearchType.type:
        searchFunction = bookService.getBooksByType;
        break;
      case SearchType.name:
      default:
        searchFunction = bookService.getBooksByName;
        break;
    }

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: FutureBuilder<List<Book>>(
        future: searchFunction(query),
        builder: (context, snapshot) {
          // ... (el resto es igual, maneja la construcción de la UI según los datos recibidos)
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Si estamos esperando los resultados, muestra un indicador de carga
            return Center(child: CircularProgressIndicator(
              color: theme.accentColor,
            ));
          } else if (snapshot.hasError) {
            // En caso de error, muestra un mensaje al usuario
            return Center(child: Text('Ha ocurrido un error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Si la consulta está completa, pero no hay datos, muestra un mensaje.
            return const Center(child: Text('No se encontraron libros.'));
          } else {
            // Si hay libros, los mostramos en un grid
            List<Book> books = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 16, left:16),
              child: GridView.builder(
                // ... (este código se mantiene igual)
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.65,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                    book: books[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 190*0.85,
                              width: 128*0.85,
                              margin: const EdgeInsets.only(right: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  books[index].coverImg,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;  // Si `loadingProgress` es null, significa que la imagen se cargó correctamente.
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        // Aquí puedes manejar la lógica del valor actual del progreso, si quieres que sea determinado.
                                        color: theme.accentColor,
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
                              width: 128*0.85,
                              child: Text(
                                books[index].title,
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
                      ),
                  );
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
    if(query.isNotEmpty){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Ahora que estamos seguros de que el widget se ha renderizado, podemos llamar a 'showResults'.
        showResults(context);
      });
    }
    return Container();
  }
}
