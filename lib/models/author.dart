class Author {
  final String authorName;
  final String authorImage; // la ruta al ícono en tus assets

  // Constructor principal
  Author({required this.authorName, required this.authorImage});

  // Constructor factory llamado 'fromJSON' para crear una instancia de Author desde un mapa (útil para Firestore)
  factory Author.fromJSON(Map<String, dynamic> json) {
    return Author(
      authorName: json['authorName'] as String, // asumimos que 'authorName' siempre está presente y es un String
      authorImage: json['authorImage'] as String, // lo mismo aplica para 'authorImage'
    );
  }

  // Método para convertir nuestra instancia de Author en un mapa, útil para subir datos a Firestore
  Map<String, dynamic> toJSON() {
    return {
      'authorName': authorName,
      'authorImage': authorImage,
    };
  }

  @override
  String toString() {
    // Proporciona una representación en cadena de este objeto, útil para depuración.
    return 'Author(authorName: $authorName, authorImage: $authorImage)';
  }

  // Si planeas comparar diferentes instancias de Author, también podría ser útil sobrescribir '=='
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    // Con una correcta comparación de tipos, verificas si el objeto es de tipo Author
    // Luego, comparas los respectivos valores de 'authorName' y 'authorImage'.
    return other is Author &&
        other.authorName == authorName &&
        other.authorImage == authorImage;
  }

  @override
  int get hashCode => authorName.hashCode ^ authorImage.hashCode;
}
