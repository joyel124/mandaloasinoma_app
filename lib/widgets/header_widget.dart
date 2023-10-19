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
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.iconColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'SaulDesign',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
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
