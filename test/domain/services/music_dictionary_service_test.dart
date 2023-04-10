import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
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
  setUp(() {
    repository = MockMusicDictionaryRepository();
    service = MusicDictionaryService(repository: repository);
    failure = Failure();
    homePageData = [AppContent(name: 'Acordes', path: '/chords')];
  });

  group('FetchHomePage', () {
    test('Failure', () async {
      when(() => repository.fetchHomePage()).thenAnswer(
        (_) => Future.value(Left(failure)),
      );
      final response = await service.fetchHomePage();
      expect(response.fold((l) => l, (r) => r), failure);
      verify(() => repository.fetchHomePage()).called(1);
    });

    test('Success', () async {
      when(() => repository.fetchHomePage()).thenAnswer(
        (_) => Future.value(Right(homePageData)),
      );
      final response = await service.fetchHomePage();
      expect(response.fold((l) => l, (r) => r), homePageData);
      verify(() => repository.fetchHomePage()).called(1);
    });
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
  });
}
