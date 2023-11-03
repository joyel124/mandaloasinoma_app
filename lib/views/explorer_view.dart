import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/routes/routes.dart';
import 'package:mandaloasinoma_app/services/authors_service.dart';
import 'package:mandaloasinoma_app/services/genders_service.dart';
import 'package:provider/provider.dart';
import '../delegates/search_book_delegate.dart';
import '../models/author.dart';
import '../models/content_provider.dart';
import '../models/gender.dart';
import '../widgets/circle_item_widget.dart';
import '../widgets/navbar_widget.dart';
import 'key_view.dart';

class Explorer extends StatefulWidget {
  const Explorer({Key? key}) : super(key: key);
  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  // Suponiendo que tienes datos de ejemplo para géneros y autores

  late Future<List<Author>> _authorsFuture;
  late Future<List<Gender>> _genresFuture;

  String _currentRoute = ExplorerRoute;
  // El ítem inicial seleccionado, cambia según tu lógica.

  @override
  void initState() {
    super.initState();
    // Inicializa las solicitudes de obtención de datos
    _authorsFuture = AuthorService().getAllAuthors();
    _genresFuture = GenderService().getAllGenres();
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
    final contenidoProvider = Provider.of<ContenidoProvider>(context, listen: true);
    return Scaffold(
      floatingActionButton: NavBar(
        onItemSelected: _handleNavBarTap, // Pasando el manejador.
        selectedItem:
            _currentRoute, // Pasando el ítem actualmente seleccionado.
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
          color: theme.textColor, // elige el color que desees para el ícono
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
            FutureBuilder<List<Gender>>(
              future: _genresFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    color: theme.accentColor,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay géneros disponibles'));
                } else {
                  var genres = snapshot.data!;
                  // Utilizando un Wrap widget aquí
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0, // espacio horizontal entre los Chips
                    runSpacing:
                        4.0, // espacio vertical entre las filas de Chips
                    children: genres.map((genre) {
                      return InkWell(
                        onTap: () {
                          // 'showSearch' inicia el 'SearchDelegate' que hemos definido.
                          contenidoProvider.contenidoDesbloqueado?showSearch(
                            context: context,
                            delegate: SearchBookDelegate(SearchType.genre), // Este es tu SearchDelegate personalizado.
                            // El query es el término de búsqueda; establecemos el género como el término inicial de búsqueda.
                            query: genre.genderName,
                          ):
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => KeyView())
                          );
                        },
                        child: Chip(
                          label: contenidoProvider.contenidoDesbloqueado?Text(genre.genderName):const Icon(Icons.lock),
                          backgroundColor: theme.accentColor,
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: theme.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 8), // Espacio entre secciones
            // Sección de Autores
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            FutureBuilder<List<Author>>(
              future: _authorsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: theme.accentColor,
                      )); // Cargando
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay autores disponibles'));
                } else {
                  // Datos obtenidos correctamente
                  var authors = snapshot.data!;
                  // Usando ListView.builder para construir la lista
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 100.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      // ... (este código se mantiene igual)
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              // 'showSearch' inicia el 'SearchDelegate' que hemos definido.
                              contenidoProvider.contenidoDesbloqueado?showSearch(
                                context: context,
                                delegate: SearchBookDelegate(SearchType.author), // Este es tu SearchDelegate personalizado.
                                // El query es el término de búsqueda; establecemos el nombre del autor como el término inicial de búsqueda.
                                query: authors[index].authorName,
                              ): Navigator.push(context,
                              MaterialPageRoute(builder: (context) => KeyView())
                              );
                            },
                            child: CircleItem(
                                name: authors[index].authorName,
                                iconPath: authors[index].authorImage));
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
