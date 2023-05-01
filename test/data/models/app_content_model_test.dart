import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_dictionary/data/models/home_page_content_model.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';

void main() {
  final map = {'name': 'Acordes', 'path': '/chords'};
  final model = HomePageContentModel(name: 'Acordes', id: '/chords');
  final entity = HomePageContent(name: 'Escalas', id: '/scales');

  group('HomePageContentModel', () {
    test('fromMap', () {
      final fromMap = HomePageContentModel.fromMap(map);
      expect(fromMap, model);
    });

    test('toMap', () {
      final toMap = model.toMap();
      expect(toMap, map);
    });

    test('fromEntity', () {
      final fromEntity = HomePageContentModel.fromEntity(entity);
      expect(fromEntity, entity);
    });

    test('toJson', () {
      final json = model.toJson();
      expect(json, jsonEncode(model.toMap()));
    });

    test('fromJson', () {
      final json = jsonEncode(map);
      final fromJson = HomePageContentModel.fromJson(json);
      expect(fromJson, model);
    });
  });
}
