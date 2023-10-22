import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/models/book.dart';
import 'package:mandaloasinoma_app/widgets/chapter_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chapter.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  const BookDetail({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

Future<void> agregarFavorito(String bookTitle) async {
  final prefs = await SharedPreferences.getInstance();

  // Obtener la lista actual de favoritos
  List<String> favoritos = prefs.getStringList('favoritos') ?? [];

  // Agregar el nuevo favorito, si no existe ya
  if (!favoritos.contains(bookTitle)) {
    favoritos.add(bookTitle);
  }

  // Guardar la lista modificada en las preferencias
  await prefs.setStringList('favoritos', favoritos);
}

Future<bool> esFavorito(String titulo) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> favoritos = prefs.getStringList('favoritos') ?? [];
  return favoritos.contains(titulo);
}

Future<void> quitarFavorito(String bookTitle) async {
  final prefs = await SharedPreferences.getInstance();

  // Obtener la lista actual de favoritos.
  List<String> favoritos = prefs.getStringList('favoritos') ?? [];

  // Remover el título del libro de la lista de favoritos, si está presente.
  favoritos.remove(bookTitle);

  // Guardar la lista modificada en las preferencias.
  await prefs.setStringList('favoritos', favoritos);
}


class _BookDetailState extends State<BookDetail> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _esFavorito = false;

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  List<Widget> _buildGenreChips() {
    // Construyendo una lista de chips de género.
    return widget.book.genders.map((String genre) {
      return Chip(
        label: Text(genre),  // configuración básica, estiliza según sea necesario
      );
    }).toList();
  }

  late final AnimationController _controllerFade = AnimationController(
    duration: const Duration(milliseconds: 765),
    vsync: this,
  );
  late final Animation<double> _animationFade = CurvedAnimation(
    parent: _controllerFade,
    curve: Curves.easeInOut,
  );
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _controller.animateTo(0.2);
    _initFavorito();
    _controllerFade.forward();
    super.initState();
  }

  Future<void> _initFavorito() async {
    // Verifica si el libro es un favorito al inicio.
    _esFavorito = await esFavorito(widget.book.title);
    setState(() {}); // Si usas setState, asegúrate de que se llame solo si el estado ha cambiado para evitar reconstrucciones innecesarias.
  }

  Future<void> toggleFavorito() async {
    if (_esFavorito) {
      // Si ya es favorito, "des-favoritar".
      await quitarFavorito(widget.book.title);
    } else {
      // Si no, entonces agregar a favoritos.
      await agregarFavorito(widget.book.title);
    }

    // Cambia el estado y actualiza la UI.
    setState(() {
      _esFavorito = !_esFavorito;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerFade.dispose();
    super.dispose();
  }

  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.book.title,
                    child: Container(
                      height: 327,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(widget.book.coverImg).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            radius: 0.7,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            color: theme.textColor,
                            height: 24,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            agregarFavorito(widget.book.title);
                            toggleFavorito();
                          },
                          icon: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return SvgPicture.asset(
                                _esFavorito
                                    ? 'assets/icons/favorite_fill.svg' // El corazón lleno
                                    : 'assets/icons/favorite_2.svg', // El contorno del corazón
                                color: theme.textColor,
                                height: 24,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          'assets/icons/share.svg',
                          color: theme.textColor,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: _animationFade,
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: MediaQuery.of(context).size.width - 32,
                        margin: const EdgeInsets.only(top: 255, bottom: 24),
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: showAll == false ? 0 : 16,
                        ),
                        decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 230,
                                  child: Text(
                                    widget.book.title,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      color: theme.textColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  height: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.book.visits}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: theme.textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SvgPicture.asset(
                                  'assets/icons/watch.svg',
                                  height: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.book.visits.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: theme.textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.book.title_jap,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                color: theme.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Resumen',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                color: theme.syspnosisColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizeTransition(
                              sizeFactor: _animation,
                              axis: Axis.vertical,
                              axisAlignment: -1,
                              child: Text(
                                widget.book.description,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: theme.syspnosisColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8.0, // espacio entre los chips
                              runSpacing: 0, // espacio entre las filas
                              children: _buildGenreChips(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'Autor: ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    color: theme.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Chip(label: Text(widget.book.author)),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showAll = !showAll;
                            if (showAll) {
                              _controller.forward();
                            } else {
                              _controller.animateTo(0.2);
                            }
                          });
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            turns: showAll == false ? 0 : 0.5,
                            child: SvgPicture.asset(
                              'assets/icons/arrow_down.svg',
                              color: theme.textColor,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Capitulos",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: theme.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (widget.book.pages != null && widget.book.pages!.isNotEmpty) ...[
                ChapterCard(
                  chapterName: "Capitulo 1",
                  chapterImage: widget.book.pages![0],
                  pages: widget.book.pages!,
                  title: widget.book.title,
                ),
              ] else ...[
                const SizedBox(height: 16),
                Center(
                  child: Text(
                      "No hay capítulos disponibles",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: theme.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}