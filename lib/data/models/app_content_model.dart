import 'dart:convert';

import 'package:music_dictionary/domain/entities/app_content.dart';

class AppContentModel extends AppContent {
  AppContentModel({
    required super.name,
    required super.path,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'path': path,
    };
  }

  factory AppContentModel.fromMap(Map<String, dynamic> map) {
    return AppContentModel(
      name: map['name'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppContentModel.fromJson(String source) => AppContentModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory AppContentModel.fromEntity(AppContent entity) => AppContentModel(
        name: entity.name,
        path: entity.path,
      );
}
