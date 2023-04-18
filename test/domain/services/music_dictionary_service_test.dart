import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MockMusicDictionaryRepository extends Mock
    implements MusicDictionaryRepository {}

void main() {
  late MusicDictionaryRepository repository;
  late MusicDictionaryService service;
  late Failure failure;
  late List<AppContent> homePageData;
  late List<Chord> chords;
  late String key;
  late String jsonHomePage;
  late String jsonChordsPage;

  setUp(() {
    repository = MockMusicDictionaryRepository();
    service = MusicDictionaryService(repository: repository);
    failure = Failure();
    homePageData = [AppContent(name: 'Acordes', path: '/chords')];
    chords = [Chord(name: 'name', images: [], description: 'description')];
    key = LocalStorageKeys.homePageData;
    jsonHomePage =
        jsonEncode([AppContent(name: 'Acordes', path: '/chords').toMap()]);
    jsonChordsPage = jsonEncode(
        [Chord(name: 'name', images: [], description: 'description').toMap()]);
  });

  group('FetchHomePage', () {
    test(
      'FetchCachedHomePage return homePageData and FetchHomePage is not called',
      () async {
        when(() => repository.fetchCachedHomePage()).thenAnswer(
          (_) => Future.value(homePageData),
        );
        when(() => repository.fetchHomePage()).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchHomePage();
        expect(response.fold((l) => l, (r) => r), homePageData);
        verify(() => repository.fetchCachedHomePage()).called(1);
        verifyNever(() => repository.fetchHomePage());
        verifyNever(() => repository.saveAppData(json: jsonHomePage, key: key));
      },
    );
    test(
      'FetchCachedHomePage return null and FetchHomePage return Failure',
      () async {
        when(() => repository.fetchCachedHomePage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchHomePage()).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchHomePage();
        expect(response.fold((l) => l, (r) => r), failure);
        verify(() => repository.fetchCachedHomePage()).called(1);
        verify(() => repository.fetchHomePage()).called(1);
        verifyNever(() => repository.saveAppData(json: jsonHomePage, key: key));
      },
    );

    test(
      'FetchCachedHomePage return null and FetchHomePage return Success and call SaveAppData',
      () async {
        when(() => repository.fetchCachedHomePage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchHomePage()).thenAnswer(
          (_) => Future.value(Right(homePageData)),
        );
        when(() => repository.saveAppData(
              key: 'HOME_PAGE_DATA',
              json: jsonHomePage,
            )).thenAnswer((invocation) => Future.value(true));
        final response = await service.fetchHomePage();
        expect(response.fold((l) => l, (r) => r), homePageData);
        verify(() => repository.fetchCachedHomePage()).called(1);
        verify(() => repository.fetchHomePage()).called(1);
        verify(() => repository.saveAppData(json: jsonHomePage, key: key))
            .called(1);
      },
    );
  });

  group('SaveAppData', () {
    test('Failure', () async {
      when(() => repository.saveAppData(key: key, json: jsonHomePage))
          .thenAnswer(
        (_) => Future.value(false),
      );
      final response = await service.saveAppData(key: key, json: jsonHomePage);
      expect(response, false);
      verify(() => repository.saveAppData(key: key, json: jsonHomePage))
          .called(1);
    });

    test('Success', () async {
      when(() => repository.saveAppData(key: key, json: jsonHomePage))
          .thenAnswer(
        (_) => Future.value(true),
      );
      final response = await service.saveAppData(key: key, json: jsonHomePage);
      expect(response, true);
      verify(() => repository.saveAppData(key: key, json: jsonHomePage))
          .called(1);
    });
  });

  group('FetchChordsPage', () {
    test(
      'FetchCachedChordsPage return Chords and FetchChordsPage is not called',
      () async {
        when(() => repository.fetchCachedChordsPage()).thenAnswer(
          (_) => Future.value(chords),
        );
        when(() => repository.fetchChordsPage()).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchChordsPage();
        expect(response.fold((l) => l, (r) => r), chords);
        verify(() => repository.fetchCachedChordsPage()).called(1);
        verifyNever(() => repository.fetchChordsPage());
      },
    );
    test(
      'FetchCachedChordsPage return null and FetchChordsPage return Failure',
      () async {
        when(() => repository.fetchCachedChordsPage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchChordsPage()).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchChordsPage();
        expect(response.fold((l) => l, (r) => r), failure);
        verify(() => repository.fetchCachedChordsPage()).called(1);
        verify(() => repository.fetchChordsPage()).called(1);
      },
    );

    test(
      'FetchCachedChordsPage return null and FetchChordsPage return Success and call SaveAppData',
      () async {
        when(() => repository.fetchCachedChordsPage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchChordsPage()).thenAnswer(
          (_) => Future.value(Right(chords)),
        );
        when(() => repository.saveAppData(
              key: LocalStorageKeys.chordsPageData,
              json: jsonChordsPage,
            )).thenAnswer((_) => Future.value(true));
        final response = await service.fetchChordsPage();
        expect(response.fold((l) => l, (r) => r), chords);
        verify(() => repository.fetchCachedChordsPage()).called(1);
        verify(() => repository.fetchChordsPage()).called(1);
        verify(() => repository.saveAppData(
              json: jsonChordsPage,
              key: LocalStorageKeys.chordsPageData,
            )).called(1);
      },
    );
  });
}
