import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';

class DoujinsSection extends StatelessWidget {
  const DoujinsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea los elementos a la izquierda.
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Doujins',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: theme.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Ver más',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: theme.accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 216,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: resentRelease.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 190,
                    width: 128,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: resentRelease[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      resentRelease[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: theme.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
