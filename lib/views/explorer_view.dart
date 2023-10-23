import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import '../models/author.dart';
import '../models/genre.dart';
import '../widgets/circle_item_widget.dart';
import '../widgets/navbar_widget.dart';

class Explorer extends StatefulWidget {

  const Explorer({Key? key}) : super(key: key);
  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  // Suponiendo que tienes datos de ejemplo para géneros y autores
  final List<Genre> genres = [
    Genre(
        name: "NTR",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"), // tu URL actual
    // Añadiendo más géneros con datos ficticios
    Genre(
        name: "Romance",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    Genre(
        name: "Fantasy",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    Genre(
        name: "Comedy",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    // Agrega tantos como necesites...
  ];

  final List<Author> authors = [
    // Añadiendo autores con datos ficticios
    Author(
        name: "Author One",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    Author(
        name: "Author Two",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    Author(
        name: "Author Three",
        iconPath:
            "https://irodoricomics.com/image/cache/catalog/Assets/Artist%20Thumbnails/Aiue_oka-100x100.jpg"),
    // Agrega tantos como necesites...
  ];

  late Future<List<String>> _futureFavorites;

  String _selectedItem = 'explorer';
  String _currentRoute = ExplorerRoute;
  // El ítem inicial seleccionado, cambia según tu lógica.
  void _onNavBarItemSelect(String item) {
    setState(() {
      _selectedItem = item;
    });
    // Aquí también puedes manejar la lógica de navegación si es necesario.
  }

  void _handleNavBarTap(String routeName) {
    setState(() {
      _currentRoute = routeName;
    });

    // Cambiar la página utilizando el enrutador
    Navigator.of(context).pushReplacementNamed(routeName);
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
        title: Text('Explorar',
            style: TextStyle(
              fontFamily: 'Oswald',
              color: theme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: theme.textColor,  // elige el color que desees para el ícono
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Otros elementos de la UI aquí (como la barra de búsqueda)
            // Sección de Géneros
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Géneros',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: theme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // para desactivar el scrolling dentro del GridView
              crossAxisCount: 4,
              children: genres.map((genre) {
                return CircleItem(name: genre.name, iconPath: genre.iconPath);
              }).toList(),
            ),

            SizedBox(height: 16), // Espacio entre secciones

            // Sección de Autores
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Autores',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: theme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // para desactivar el scrolling dentro del GridView
              crossAxisCount: 4,
              children: authors.map((author) {
                return CircleItem(name: author.name, iconPath: author.iconPath);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
