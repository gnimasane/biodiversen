// lib/models/observation.dart

import 'dart:typed_data';

enum TypeEspece { faune, flore }

class Observation {
  final String      nom;
  final TypeEspece  type;
  final String      parc;
  final DateTime    date;
  final bool        menacee;
  final String?     imagePath;   // asset local
  final Uint8List?  imageBytes;  // photo choisie depuis galerie

  const Observation({
    required this.nom,
    required this.type,
    required this.parc,
    required this.date,
    required this.menacee,
    this.imagePath,
    this.imageBytes,
  });

  static int compterMenacees(List<Observation> liste) {
    return liste.where((o) => o.menacee).length;
  }

  Map<String, dynamic> toMap() {
    return {
      'nom'     : nom,
      'type'    : type.name,
      'parc'    : parc,
      'date'    : date.toIso8601String(),
      'menacee' : menacee,
      'imagePath': imagePath,
    };
  }

  Observation copyWith({
    String?     nom,
    TypeEspece? type,
    String?     parc,
    DateTime?   date,
    bool?       menacee,
    String?     imagePath,
    Uint8List?  imageBytes,
  }) {
    return Observation(
      nom       : nom       ?? this.nom,
      type      : type      ?? this.type,
      parc      : parc      ?? this.parc,
      date      : date      ?? this.date,
      menacee   : menacee   ?? this.menacee,
      imagePath : imagePath ?? this.imagePath,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }
}