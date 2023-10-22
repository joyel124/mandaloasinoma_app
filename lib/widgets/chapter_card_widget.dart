import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/chapter.dart';


// Primero, definimos una clase para representar los datos de un capítulo.
// Si ya tienes una clase para 'Chapter', puedes usarla en lugar de esta

// Luego, definimos el widget 'ChapterCard'.
class ChapterCard extends StatelessWidget {
  final String chapterName;
  final String chapterImage;

  const ChapterCard({
    Key? key,
    required this.chapterName,
    required this.chapterImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(8),
      height: 96,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: theme.accentColor,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 84,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: NetworkImage(chapterImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chapterName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
