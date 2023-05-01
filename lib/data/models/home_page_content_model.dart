import 'dart:convert';

import 'package:music_dictionary/domain/entities/home_page_content.dart';

class HomePageContentModel extends HomePageContent {
  HomePageContentModel({
    required super.name,
    required super.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory HomePageContentModel.fromMap(Map<String, dynamic> map) {
    return HomePageContentModel(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HomePageContentModel.fromJson(String source) =>
      HomePageContentModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory HomePageContentModel.fromEntity(HomePageContent entity) =>
      HomePageContentModel(
        name: entity.name,
        id: entity.id,
      );
}
