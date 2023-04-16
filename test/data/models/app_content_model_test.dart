import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';

void main() {
  final map = {'name': 'Acordes', 'path': '/chords'};
  final model = AppContentModel(name: 'Acordes', path: '/chords');
  final entity = AppContent(name: 'Escalas', path: '/scales');

  group('AppContentModel', () {
    test('fromMap', () {
      final fromMap = AppContentModel.fromMap(map);
      expect(fromMap, model);
    });

    test('toMap', () {
      final toMap = model.toMap();
      expect(toMap, map);
    });

    test('fromEntity', () {
      final fromEntity = AppContentModel.fromEntity(entity);
      expect(fromEntity, entity);
    });

    test('toJson', () {
      final json = model.toJson();
      expect(json, jsonEncode(model.toMap()));
    });

    test('fromJson', () {
      final json = jsonEncode(map);
      final fromJson = AppContentModel.fromJson(json);
      expect(fromJson, model);
    });
  });
}
