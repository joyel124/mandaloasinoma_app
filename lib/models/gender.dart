class Gender {
  final String genderName;

  // Constructor principal
  Gender({required this.genderName});

  // Constructor factory llamado 'fromJSON' para crear una instancia de Genre desde un mapa (útil para Firestore)
  factory Gender.fromJSON(Map<String, dynamic> json) {
    return Gender(
      genderName: json['genderName'] as String, // asumimos que 'genderName' siempre está presente y es un String
    );
  }

  // Método para convertir nuestra instancia de Genre en un mapa, útil para subir datos a Firestore
  Map<String, dynamic> toJSON() {
    return {
      'genderName': genderName,
    };
  }

  @override
  String toString() {
    // Proporciona una representación en cadena de este objeto, útil para depuración.
    return 'Genre(genderName: $genderName)';
  }

  // Si planeas comparar diferentes instancias de Genre, también podría ser útil sobrescribir '=='
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    // Con una correcta comparación de tipos, verificas si el objeto es de tipo Genre
    // Luego, comparas los respectivos valores de genderName.
    return other is Gender && other.genderName == genderName;
  }

  @override
  int get hashCode => genderName.hashCode;
}
