import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chord {
  final String name;
  final List<String> images;
  final String description;

  Chord({
    required this.name,
    required this.images,
    required this.description,
  });

  Chord copyWith({
    String? name,
    List<String>? images,
    String? description,
  }) {
    return Chord(
      name: name ?? this.name,
      images: images ?? this.images,
      description: description ?? this.description,
    );
  }

  @override
  String toString() =>
      'Chord(name: $name, images: $images, description: $description)';

  @override
  bool operator ==(covariant Chord other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.images, images) &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ images.hashCode ^ description.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'images': images,
      'description': description,
    };
  }

  factory Chord.fromMap(Map<String, dynamic> map) {
    return Chord(
      name: map['name'] as String,
      images: List<String>.from((map['images'] as List<String>)),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chord.fromJson(String source) =>
      Chord.fromMap(json.decode(source) as Map<String, dynamic>);
}
