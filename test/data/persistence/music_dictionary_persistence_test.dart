import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPrefs extends Mock implements SharedPreferences {}

void main() {
  late final MockSharedPrefs sharedPrefs;
  late final SharedPrefsMusicDictionaryPersistence persistence;
  late final List<AppContent> homePageData;
  late final String json;

  setUp(() {
    sharedPrefs = MockSharedPrefs();
    persistence = SharedPrefsMusicDictionaryPersistence(
      sharedPreferences: sharedPrefs,
    );
    homePageData = [AppContent(name: 'Acordes', path: '/chords')];
    json = jsonEncode(homePageData
        .map((e) => AppContentModel.fromEntity(e).toMap())
        .toList());
  });

  group('SharedPrefsMusicDictionaryPersistence', () {
    test('SaveAppData', () async {
      when(
        () => sharedPrefs.setString(LocalStorageKeys.homePageData, json),
      ).thenAnswer((_) => Future.value(true));
      final response = await persistence.saveAppData(
        key: LocalStorageKeys.homePageData,
        json: json,
      );
      expect(response, true);
    });
  });
}
