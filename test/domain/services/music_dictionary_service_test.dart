import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/entities/chords.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MockMusicDictionaryRepository extends Mock
    implements MusicDictionaryRepository {}

void main() {
  late MusicDictionaryRepository repository;
  late MusicDictionaryService service;
  late Failure failure;
  late List<AppContent> homePageData;
  late List<Chord> chords;
  setUp(() {
    repository = MockMusicDictionaryRepository();
    service = MusicDictionaryService(repository: repository);
    failure = Failure();
    homePageData = [AppContent(name: 'Acordes', path: '/chords')];
    chords = [Chord(name: 'name', images: [], description: 'description')];
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
      },
    );

    test(
      'FetchCachedHomePage return null and FetchHomePage return Success',
      () async {
        when(() => repository.fetchCachedHomePage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchHomePage()).thenAnswer(
          (_) => Future.value(Right(homePageData)),
        );
        final response = await service.fetchHomePage();
        expect(response.fold((l) => l, (r) => r), homePageData);
        verify(() => repository.fetchCachedHomePage()).called(1);
        verify(() => repository.fetchHomePage()).called(1);
      },
    );
  });

  group('SaveHomePage', () {
    test('Failure', () async {
      when(() => repository.saveHomePageData(homePageData)).thenAnswer(
        (_) => Future.value(false),
      );
      final response = await service.saveHomePageData(homePageData);
      expect(response, false);
      verify(() => repository.saveHomePageData(homePageData)).called(1);
    });

    test('Success', () async {
      when(() => repository.saveHomePageData(homePageData)).thenAnswer(
        (_) => Future.value(true),
      );
      final response = await service.saveHomePageData(homePageData);
      expect(response, true);
      verify(() => repository.saveHomePageData(homePageData)).called(1);
    });

    test('Not called when returned cached data', () async {
      when(() => repository.saveHomePageData(homePageData)).thenAnswer(
        (_) => Future.value(true),
      );
      service.returnedCached = true;
      final response = await service.saveHomePageData(homePageData);
      expect(response, true);
      verifyNever(() => repository.saveHomePageData(homePageData));
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
      'FetchCachedChordsPage return null and FetchChordsPage return Success',
      () async {
        when(() => repository.fetchCachedChordsPage()).thenAnswer(
          (_) => Future.value(null),
        );
        when(() => repository.fetchChordsPage()).thenAnswer(
          (_) => Future.value(Right(chords)),
        );
        final response = await service.fetchChordsPage();
        expect(response.fold((l) => l, (r) => r), chords);
        verify(() => repository.fetchCachedChordsPage()).called(1);
        verify(() => repository.fetchChordsPage()).called(1);
      },
    );
  });
}
