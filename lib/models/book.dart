class Book {
  final String id;
  final String title;
  final String author;
  // otros campos que necesites, como descripción, capítulos, etc.

  Book({
    required this.id,
    required this.title,
    required this.author,
    // otros campos...
  });

  // Convertir un mapa en un objeto de tipo Manga.
  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author']
  // otros campos...
  ;

  // Convertir un objeto de tipo Manga en un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      // otros campos...
    };
  }
}
