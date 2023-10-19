import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';
import '../views/anime_view.dart';

class MostPopularSection extends StatelessWidget{
  const MostPopularSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Más Populares',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Oswald',
              color: theme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: mostPopular.length,
            itemBuilder: ((context, index) {
              return Stack(
                children: [
                  Hero(
                    tag: mostPopular[index].title,
                    child: Container(
                      height: 200,
                      width: 296,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: mostPopular[index].image,
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
                            builder: (context) => Anime(
                              anime: mostPopular[index],
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
                                mostPopular[index].title,
                                textAlign: TextAlign.left,
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
                                      'assets/icons/star.svg',
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${mostPopular[index].score}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: theme.textColor,
                                        fontSize: 12,
                                        height: 2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Chapters: ${mostPopular[index].chapterCount}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: theme.textColor,
                                        fontSize: 12,
                                        height: 2,
                                        fontWeight: FontWeight.w500,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black54,
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
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
            }),
          ),
        ),
      ],
    );
  }
}