import 'dart:convert';

import 'package:music_dictionary/domain/entities/chord.dart';

class ChordModel extends Chord {
  ChordModel({
    required super.name,
    required super.images,
    required super.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'images': images,
      'description': description,
    };
  }

  factory ChordModel.fromMap(Map<String, dynamic> map) {
    List<String> images = [];
    if (map['images'] is List) {
      (map['images']).forEach((e) => images.add(e));
    }
    return ChordModel(
      name: map['name'] ?? '',
      images: images,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChordModel.fromJson(String source) =>
      ChordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ChordModel.fromEntity(Chord entity) => ChordModel(
        name: entity.name,
        images: entity.images,
        description: entity.description,
      );
}
