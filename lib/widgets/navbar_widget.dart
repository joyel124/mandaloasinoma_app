import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/data.dart';
import '../routes/routes.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, HomeRoute);
                },
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                ),
              ),
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, FavoritesRoute);
                },
                icon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                ),
              ),
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, ExplorerRoute);
                },
                icon: SvgPicture.asset(
                  'assets/icons/explorer.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
