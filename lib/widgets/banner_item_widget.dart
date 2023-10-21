import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data/data.dart';
import '../models/book.dart';
import '../views/book_detail_view.dart';

class BannerItemBook extends StatelessWidget {
  final Book book;
  const BannerItemBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: book.title,
          child: Container(
            height: 200,
            width: 296,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(book.coverImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetail(
                    book: book,
                  ),
                ),
              );
            },
            child: Center(
              child: Container(
                height: 200,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 26,
                ),
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.6,
                    colors: [
                      Colors.black12,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      book.title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        color: theme.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/watch.svg',
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${book.visits}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: theme.textColor,
                              fontSize: 12,
                              height: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}