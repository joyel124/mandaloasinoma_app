import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String title;
  final String title_jap;
  final String author;
  final String description;
  final List<String> genders;
  final String link_download;
  final String type;
  final int visits;
  final String coverImg;
  final DateTime publicationDate;

  // otros campos que necesites, como descripción, capítulos, etc.

  Book({
    required this.title,
    required this.title_jap,
    required this.author,
    required this.description,
    required this.genders,
    required this.link_download,
    required this.type,
    required this.visits,
    required this.coverImg,
    required this.publicationDate,
    // otros campos...
  });

  factory Book.fromJson(Map<String, dynamic> map) {
    // Convertir el Timestamp en un objeto DateTime
    var timestamp = map['publicationDate'] as Timestamp;
    DateTime publicationDate = timestamp.toDate();

    // Asegurarse de que el campo de géneros sea una lista de cadenas
    List<String> genders = List<String>.from(map['genders'] as List<dynamic>);

    return Book(
      title: map['title'] as String,
      title_jap: map['title_jap'] as String,
      author: map['author'] as String,
      description: map['description'] as String,
      genders: genders,
      link_download: map['link_download'] as String,
      type: map['type'] as String,
      visits: map['visits'] as int,
      coverImg: map['coverImg'] as String,
      publicationDate: publicationDate
    );
  }

  // Convertir un objeto de tipo Manga en un mapa.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'title_jap': title_jap,
      'author': author,
      'description': description,
      'genders': genders,
      'link_download': link_download,
      'type': type,
      'visits': visits,
      'coverImg': coverImg,
      'publicationDate': publicationDate.millisecondsSinceEpoch.toString(),
    };
  }
}
