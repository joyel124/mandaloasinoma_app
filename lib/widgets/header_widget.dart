import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/data.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.accentColor,
            ),
            child: SvgPicture.asset(
              'assets/icons/perfil.svg',
              height: 24,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/search.svg',
            height: 24,
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(
            'assets/icons/notifications.svg',
            height: 24,
          ),
        ],
      ),
    );
  }
}
