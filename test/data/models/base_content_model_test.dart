import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_dictionary/data/models/base_content_model.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';

void main() {
  final map = {
    'name': 'A',
    'images': ['img1'],
    'description': 'description'
  };
  final model = BaseContentModel(
    name: 'A',
    images: ['img1'],
    description: 'description',
  );

  final entity = BaseContent(
    name: 'A',
    images: ['img1'],
    description: 'description',
  );

  group('BaseContentModel', () {
    test('fromMap', () {
      final fromMap = BaseContentModel.fromMap(map);
      expect(fromMap, model);
    });

    test('toMap', () {
      final toMap = model.toMap();
      expect(toMap, map);
    });

    test('fromEntity', () {
      final fromEntity = BaseContentModel.fromEntity(entity);
      expect(fromEntity, model);
    });

    test('toJson', () {
      final json = model.toJson();
      expect(json, jsonEncode(model.toMap()));
    });

    test('fromJson', () {
      final json = jsonEncode(map);
      final fromJson = BaseContentModel.fromJson(json);
      expect(fromJson, model);
    });
  });
}
