import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import '../models/book.dart';
import '../services/books_service.dart';
import '../widgets/navbar_widget.dart';
import 'book_detail_view.dart';

Future<List<String>> obtenerFavoritos() async {
  final prefs = await SharedPreferences.getInstance();

  // Devolver la lista de favoritos o una lista vacía si no existe
  return prefs.getStringList('favoritos') ?? [];
}

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Future<List<String>> _futureFavorites;

  String _currentRoute = FavoritesRoute;

  void _handleNavBarTap(String routeName) {
    setState(() {
      _currentRoute = routeName;
    });

    // Cambiar la página utilizando el enrutador
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  void initState() {
    super.initState();
    // Inicializa tu Future en initState.
    _futureFavorites = obtenerFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NavBar(
        onItemSelected: _handleNavBarTap,  // Pasando el manejador.
        selectedItem: _currentRoute,  // Pasando el ítem actualmente seleccionado.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: TextStyle(
            fontFamily: 'Oswald',
            color: theme.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: theme.textColor,  // elige el color que desees para el ícono
        ),
        // Si quieres, puedes hacer que la AppBar sea transparente para un diseño más moderno
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<String>>(
        future: _futureFavorites,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          // Comprobando si hay un error
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrió un error: ${snapshot.error}'));
          }

          // Comprobando si los datos están disponibles y no son nulos
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            List<String> favoriteItems = snapshot.data!;

            // Si no hay elementos favoritos, muestra un mensaje.
            if (favoriteItems.isEmpty) {
              return Center(child: Text('No tienes ningún favorito aún.'));
            }

            // Construyendo la lista con datos reales
            return ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                return FavoriteItemCard(itemTitle: favoriteItems[index]);
              },
            );
          }

          // Mientras se carga la información, muestra un indicador de progreso
          return Center(child: CircularProgressIndicator(
            color: theme.accentColor,
          ));
        },
      ),
    );
  }
}

// Puedes incluir este widget en el mismo archivo o en uno separado.
class FavoriteItemCard extends StatefulWidget {
  final String itemTitle;

  FavoriteItemCard({Key? key, required this.itemTitle}) : super(key: key);

  @override
  _FavoriteItemCardState createState() => _FavoriteItemCardState();
}

class _FavoriteItemCardState extends State<FavoriteItemCard> {
  late BookService bookService; // Define bookService

  @override
  void initState() {
    super.initState();
    bookService = BookService(); // Inicializa bookService
  }

  void navigateToDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetail(
          book: book,
        ),
      ),
    );
  }

  Future<void> handleTap() async {
    try {
      Book? book = await bookService.getBookByName(widget.itemTitle);
      if (book != null) {
        navigateToDetail(book);
      } else {
        // Manéjalo si el libro no se encuentra
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Libro no encontrado')));
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la búsqueda
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al buscar el libro')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        title: Text(
          widget.itemTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 24,
        ),
        onTap: handleTap,
      ),
    );
  }
}
