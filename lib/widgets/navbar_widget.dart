import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';
import '../routes/routes.dart';

class NavBar extends StatelessWidget {

  final Function(String) onItemSelected;
  final String selectedItem;

  const NavBar({
    super.key,
    required this.onItemSelected,
    required this.selectedItem,  // Puedes usar el valor que corresponda a tu ítem inicial.
  });

  Widget _buildIconButton({
    required String routeName,
    required String assetName,
    required Color color,
  }) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => onItemSelected(routeName),
        icon: SvgPicture.asset(assetName, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor = Colors.white.withOpacity(0.5);
    return Hero(
      tag: 'bottom_bar',
      child: Container(
        height: 64,
        margin: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: theme.accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconButton(
              routeName: HomeRoute,  // Cambia esto por el nombre de tu ruta/ítem.
              assetName: 'assets/icons/home.svg',
              // El color depende de si este ítem está seleccionado.
              color: selectedItem == HomeRoute ? Colors.white : inactiveColor,
            ),
            _buildIconButton(
              routeName: FavoritesRoute,  // Cambia esto por el nombre de tu ruta/ítem.
              assetName: 'assets/icons/favorite.svg',
              // El color depende de si este ítem está seleccionado.
              color: selectedItem == FavoritesRoute ? Colors.white : inactiveColor,
            ),
            _buildIconButton(
              routeName: ExplorerRoute,  // Cambia esto por el nombre de tu ruta/ítem.
              assetName: 'assets/icons/explorer.svg',
              // El color depende de si este ítem está seleccionado.
              color: selectedItem == ExplorerRoute ? Colors.white : inactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}
