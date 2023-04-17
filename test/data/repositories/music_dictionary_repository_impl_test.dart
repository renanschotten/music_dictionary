import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/data/models/chord_model.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/data/repositories/music_dictionary_repository_impl.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
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
  final appContentModel = [AppContentModel(name: 'Acordes', path: '/chords')];
  final appContentEntity = [AppContent(name: 'Acordes', path: '/chords')];
  final failure = Failure();
  final chords = [
    ChordModel(name: 'A', images: ['images'], description: 'description')
  ];

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

    test('SaveHomePageData Failure', () async {
      when(() => persistence.saveHomePageData(appContentEntity)).thenAnswer(
        (_) => Future.value(false),
      );
      final response = await repository.saveHomePageData(appContentEntity);
      expect(response, false);
    });

    test('SaveHomePageData Success', () async {
      when(() => persistence.saveHomePageData(appContentEntity)).thenAnswer(
        (_) => Future.value(true),
      );
      final response = await repository.saveHomePageData(appContentEntity);
      expect(response, true);
    });

    test('FetchChordsPage Failure', () async {
      when(() => datasource.fetchChordsPage()).thenAnswer(
        (_) => Future.value(Left(failure)),
      );
      final response = await repository.fetchChordsPage();
      expect(response.fold((l) => l, (r) => r), failure);
    });

    test('FetchChordsPage Success', () async {
      when(() => datasource.fetchChordsPage()).thenAnswer(
        (_) => Future.value(Right(chords)),
      );
      final response = await repository.fetchChordsPage();
      expect(response.fold((l) => l, (r) => r), chords);
    });

    test('FetchCachedChordsPage Failure', () async {
      when(() => persistence.fetchChordsPage()).thenAnswer(
        (_) => Future.value(null),
      );
      final response = await repository.fetchCachedChordsPage();
      expect(response, null);
    });

    test('FetchCachedChordsPage Success', () async {
      when(() => persistence.fetchChordsPage()).thenAnswer(
        (_) => Future.value(chords),
      );
      final response = await repository.fetchCachedChordsPage();
      expect(response, chords);
    });
  });
}
