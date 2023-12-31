import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';
import '../delegates/search_book_delegate.dart';
import '../models/content_provider.dart';
import '../views/key_view.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    final contenidoProvider = Provider.of<ContenidoProvider>(context, listen: true);
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
          IconButton(onPressed: () {
            contenidoProvider.contenidoDesbloqueado?showSearch(
                context: context,
                delegate: SearchBookDelegate(SearchType.name)
            ): Navigator.push(context,
              MaterialPageRoute(builder: (context) => KeyView(),
            ),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/search.svg',
            height: 24,
          ),
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
