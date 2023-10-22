import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chapter {
  final int number;
  final String image;

  Chapter({
    required this.number,
    required this.image,
  });

  // Método que convierte un DocumentSnapshot en una instancia de Chapter
  factory Chapter.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Chapter(
      number: data['number'] ?? 0, // Asume que el campo se llama 'number' en Firestore
      image: data['image'] ?? '', // Asume que el campo se llama 'image' en Firestore
    );
  }
}
