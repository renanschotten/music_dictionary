import 'dart:convert';

import 'package:flutter/foundation.dart';

class BaseContent {
  final String name;
  final List<String> images;
  final String description;

  BaseContent({
    required this.name,
    required this.images,
    required this.description,
  });

  BaseContent copyWith({
    String? name,
    List<String>? images,
    String? description,
  }) {
    return BaseContent(
      name: name ?? this.name,
      images: images ?? this.images,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'images': images,
      'description': description,
    };
  }

  factory BaseContent.fromMap(Map<String, dynamic> map) {
    return BaseContent(
      name: map['name'] as String,
      images: List<String>.from((map['images'] as List<String>)),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseContent.fromJson(String source) =>
      BaseContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BaseContent(name: $name, images: $images, description: $description)';

  @override
  bool operator ==(covariant BaseContent other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.images, images) &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ images.hashCode ^ description.hashCode;
}
