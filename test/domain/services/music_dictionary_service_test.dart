import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
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
  late List<HomePageContent> homePageData;
  late List<BaseContent> baseContent;
  late String key;
  late String jsonHomePage;
  late String jsonBaseContent;

  setUp(() {
    repository = MockMusicDictionaryRepository();
    service = MusicDictionaryService(repository: repository);
    failure = Failure();
    homePageData = [HomePageContent(name: 'Acordes', id: '/chords')];
    baseContent = [
      BaseContent(name: 'name', images: [], description: 'description')
    ];
    key = LocalStorageKeys.homePageData;
    jsonHomePage =
        jsonEncode([HomePageContent(name: 'Acordes', id: '/chords').toMap()]);
    jsonBaseContent = jsonEncode([
      BaseContent(name: 'name', images: [], description: 'description').toMap()
    ]);
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

  group('FetchContent', () {
    test(
      'FetchCachedContent returns BaseContent for parameter "chords" and FetchContent is not called',
      () async {
        when(() => repository.fetchCachedContent(id: 'chords')).thenAnswer(
          (_) => Future.value(baseContent),
        );
        when(() => repository.fetchContent(id: 'chords')).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchContent(id: 'chords');
        expect(response.fold((l) => l, (r) => r), baseContent);
        verify(() => repository.fetchCachedContent(id: 'chords')).called(1);
        verifyNever(() => repository.fetchContent(id: 'chords'));
      },
    );
    test(
      'FetchCachedContent return null and FetchContent return Failure',
      () async {
        when(() => repository.fetchCachedContent(id: 'chords')).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchContent(id: 'chords')).thenAnswer(
          (_) => Future.value(Left(failure)),
        );
        final response = await service.fetchContent(id: 'chords');
        expect(response.fold((l) => l, (r) => r), failure);
        verify(() => repository.fetchCachedContent(id: 'chords')).called(1);
        verify(() => repository.fetchContent(id: 'chords')).called(1);
      },
    );

    test(
      'FetchCachedContent return null and FetchContent return Success and call SaveAppData',
      () async {
        when(() => repository.fetchCachedContent(id: 'chords')).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchContent(id: 'chords')).thenAnswer(
          (_) => Future.value(Right(baseContent)),
        );
        when(() => repository.saveAppData(
              key: LocalStorageKeys.chordsPageData,
              json: jsonBaseContent,
            )).thenAnswer((_) => Future.value(true));
        final response = await service.fetchContent(id: 'chords');
        expect(response.fold((l) => l, (r) => r), baseContent);
        verify(() => repository.fetchCachedContent(id: 'chords')).called(1);
        verify(() => repository.fetchContent(id: 'chords')).called(1);
        verify(() => repository.saveAppData(
              json: jsonBaseContent,
              key: LocalStorageKeys.chordsPageData,
            )).called(1);
      },
    );
  });
}
