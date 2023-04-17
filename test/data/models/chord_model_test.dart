import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_dictionary/data/models/chord_model.dart';
import 'package:music_dictionary/domain/entities/chord.dart';

void main() {
  final map = {
    'name': 'A',
    'images': ['img1'],
    'description': 'description'
  };
  final model = ChordModel(
    name: 'A',
    images: ['img1'],
    description: 'description',
  );

  final entity = Chord(
    name: 'A',
    images: ['img1'],
    description: 'description',
  );

  group('ChordModel', () {
    test('fromMap', () {
      final fromMap = ChordModel.fromMap(map);
      expect(fromMap, model);
    });

    test('toMap', () {
      final toMap = model.toMap();
      expect(toMap, map);
    });

    test('fromEntity', () {
      final fromEntity = ChordModel.fromEntity(entity);
      expect(fromEntity, model);
    });

    test('toJson', () {
      final json = model.toJson();
      expect(json, jsonEncode(model.toMap()));
    });

    test('fromJson', () {
      final json = jsonEncode(map);
      final fromJson = ChordModel.fromJson(json);
      expect(fromJson, model);
    });
  });
}
