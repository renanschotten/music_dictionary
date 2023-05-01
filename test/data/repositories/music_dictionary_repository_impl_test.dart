import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/data/models/home_page_content_model.dart';
import 'package:music_dictionary/data/models/base_content_model.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/data/repositories/music_dictionary_repository_impl.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MockFirestoreMusicDictionaryDatasource extends Mock
    implements FirestoreMusicDictionaryDatasource {}

class MockSharedPrefsMusicDictionaryPersistence extends Mock
    implements SharedPrefsMusicDictionaryPersistence {}

void main() {
  final datasource = MockFirestoreMusicDictionaryDatasource();
  final persistence = MockSharedPrefsMusicDictionaryPersistence();
  final repository = MusicDictionaryRepositoryImpl(
    datasource: datasource,
    persistence: persistence,
  );
  final appContentModel = [
    HomePageContentModel(name: 'Acordes', id: '/chords')
  ];
  final failure = Failure();
  final baseContentModel = [
    BaseContentModel(name: 'A', images: ['images'], description: 'description')
  ];
  final json = HomePageContentModel(name: 'Acordes', id: '/chords').toJson();
  const key = LocalStorageKeys.homePageData;

  group('MusicDictionaryRepositoryImpl', () {
    test('FetchHomePage Failure', () async {
      when(() => datasource.fetchHomePage()).thenAnswer(
        (_) => Future.value(Left(failure)),
      );
      final response = await repository.fetchHomePage();
      expect(response.fold((l) => l, (r) => r), failure);
    });

    test('FetchHomePage Success', () async {
      when(() => datasource.fetchHomePage()).thenAnswer(
        (_) => Future.value(Right(appContentModel)),
      );
      final response = await repository.fetchHomePage();
      expect(response.fold((l) => l, (r) => r), appContentModel);
    });

    test('FetchCachedHomePage Failure', () async {
      when(() => persistence.fetchHomePage()).thenAnswer(
        (_) => Future.value(null),
      );
      final response = await repository.fetchCachedHomePage();
      expect(response, null);
    });

    test('FetchCachedHomePage Success', () async {
      when(() => persistence.fetchHomePage()).thenAnswer(
        (_) => Future.value(appContentModel),
      );
      final response = await repository.fetchCachedHomePage();
      expect(response, appContentModel);
    });

    test('SaveAppData Failure', () async {
      when(() => persistence.saveAppData(key: key, json: json)).thenAnswer(
        (_) => Future.value(false),
      );
      final response = await repository.saveAppData(key: key, json: json);
      expect(response, false);
    });

    test('SaveAppData Success', () async {
      when(() => persistence.saveAppData(key: key, json: json)).thenAnswer(
        (_) => Future.value(true),
      );
      final response = await repository.saveAppData(key: key, json: json);
      expect(response, true);
    });

    test('FetchContent Failure', () async {
      when(() => datasource.fetchContent(id: 'chords')).thenAnswer(
        (_) => Future.value(Left(failure)),
      );
      final response = await repository.fetchContent(id: 'chords');
      expect(response.fold((l) => l, (r) => r), failure);
    });

    test('FetchContent Success', () async {
      when(() => datasource.fetchContent(id: 'chords')).thenAnswer(
        (_) => Future.value(Right(baseContentModel)),
      );
      final response = await repository.fetchContent(id: 'chords');
      expect(response.fold((l) => l, (r) => r), baseContentModel);
    });

    test('FetchCachedContent Failure', () async {
      when(() => persistence.fetchContent(id: 'chords')).thenAnswer(
        (_) => Future.value(null),
      );
      final response = await repository.fetchCachedContent(id: 'chords');
      expect(response, null);
    });

    test('FetchCachedContent Success', () async {
      when(() => persistence.fetchContent(id: 'chords')).thenAnswer(
        (_) => Future.value(baseContentModel),
      );
      final response = await repository.fetchCachedContent(id: 'chords');
      expect(response, baseContentModel);
    });
  });
}
