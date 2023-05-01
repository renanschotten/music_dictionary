import 'dart:convert';

import 'package:music_dictionary/domain/entities/base_content.dart';

class BaseContentModel extends BaseContent {
  BaseContentModel({
    required super.name,
    required super.images,
    required super.description,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'images': images,
      'description': description,
    };
  }

  factory BaseContentModel.fromMap(Map<String, dynamic> map) {
    List<String> images = [];
    if (map['images'] is List) {
      (map['images']).forEach((e) => images.add(e));
    }
    return BaseContentModel(
      name: map['name'] ?? '',
      images: images,
      description: map['description'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory BaseContentModel.fromJson(String source) =>
      BaseContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory BaseContentModel.fromEntity(BaseContent entity) => BaseContentModel(
        name: entity.name,
        images: entity.images,
        description: entity.description,
      );
}
