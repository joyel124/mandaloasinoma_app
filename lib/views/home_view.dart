import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/widgets/header_widget.dart';
import 'package:mandaloasinoma_app/widgets/most_popular_widget.dart';

import '../routes/routes.dart';
import '../widgets/coming_soon_widget.dart';
import '../widgets/doujin_widget.dart';
import '../widgets/manga_widget.dart';
import '../widgets/navbar_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedItem = 'home';  // El ítem inicial seleccionado, cambia según tu lógica.
  String _currentRoute = HomeRoute;  // La ruta actual, cambia según tu lógica.
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
      backgroundColor: theme.backgroundColor,
      floatingActionButton: NavBar(
        onItemSelected: _handleNavBarTap,  // Pasando el manejador.
        selectedItem: _currentRoute,  // Pasando el ítem actualmente seleccionado.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 24),
              MostPopularSection(),
              SizedBox(height: 24),
              MangasSection(),
              SizedBox(height: 24),
              DoujinsSection(),
              SizedBox(height: 24),
              ComingSoonSection(),
            ],
          ),
        ),
      ),
    );
  }
}