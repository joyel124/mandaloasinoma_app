import 'package:flutter/material.dart';

import '../data/data.dart';

// Paso 1: Convertir ChapterView en un StatefulWidget
class ChapterView extends StatefulWidget {
  final List<String> pages;
  final String title;

  ChapterView({required this.pages, required this.title});

  @override
  _ChapterViewState createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  // Paso 2: Agregar un estado para el tipo de vista
  late PageController _pageController; // Controlador para el PageView.
  int _currentPage = 0; // Mantener un registro de la página actual.
  bool isCascadeView =
      false; // false significa que la vista por defecto no es en cascada.

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Inicializar el controlador.
  }

  // Método para generar puntos indicadores
  Widget _buildPageIndicator(int pageIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: _currentPage == pageIndex
          ? 12.0
          : 8.0, // Si es la página actual, el punto es más grande.
      width: _currentPage == pageIndex ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == pageIndex
            ? Colors.blue
            : Colors.grey, // Color diferente para la página actual.
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Es importante desechar el controlador para evitar fugas de memoria.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        iconTheme: IconThemeData(
          color: theme.textColor,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Oswald',
            color: theme.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        // Paso 3: Agregar acciones al AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              // Cambiar el ícono dependiendo del estado de la vista
              isCascadeView ? Icons.view_carousel : Icons.view_day,
            ),
            onPressed: () {
              // Cambiar entre vistas y actualizar el estado
              setState(() {
                isCascadeView = !isCascadeView;
              });
            },
          ),
        ],
      ),
      body: isCascadeView
          // Vista en cascada
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // número de columnas
                childAspectRatio:
                    0.7, // relación entre ancho y alto de las celdas
              ),
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.pages[index], // la URL de la imagen
                  fit: BoxFit
                      .cover, // esto ayudará a evitar distorsiones en la imagen
                );
              },
            )
          // Vista de lado a lado
          : GestureDetector(
              onTap: () {
                // Al tocar, mostrar u ocultar la barra de indicadores.
                setState(() {
                  // [Aquí podrías cambiar el estado que controla si la barra de indicadores se muestra o no]
                });
              },
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: widget.pages.length,
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page; // Actualizar la página actual.
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.pages[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                  Positioned(
                    bottom:
                        16.0, // Posicionado en la parte inferior de la pantalla.
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.pages.asMap().entries.map((entry) {
                        // Genera un punto indicador por cada página.
                        return _buildPageIndicator(entry.key);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
