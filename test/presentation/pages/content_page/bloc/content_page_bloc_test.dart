import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MockMusicDictionaryService extends Mock
    implements MusicDictionaryService {}

void main() {
  late MusicDictionaryService service;
  late ContentPageBloc bloc;
  final Failure failure = GenericFailure(message: 'message');
  final List<Chord> chordsPageData = [
    Chord(name: 'name', images: ['images'], description: 'description')
  ];

  setUp(() {
    service = MockMusicDictionaryService();
    bloc = ContentPageBloc(service: service);
  });

  group('ContentPageBloc', () {
    blocTest<ContentPageBloc, ContentPageState>(
      'Should emit [ContentPageLoading, ContentPageFailure] when return Failure from service',
      build: () => bloc,
      setUp: () => when(() => service.fetchChordsPage()).thenAnswer(
        (_) => Future.value(
          Left(failure),
        ),
      ),
      act: (bloc) => bloc.add(FetchContentPageEvent()),
      expect: () => [isA<ContentPageLoading>(), isA<ContentPageFailure>()],
    );

    blocTest<ContentPageBloc, ContentPageState>(
      'Should emit [ContentPageLoading, ContentPageSuccess] when return List<Chord> from service',
      build: () => bloc,
      setUp: () => when(() => service.fetchChordsPage()).thenAnswer(
        (_) => Future.value(
          Right(chordsPageData),
        ),
      ),
      act: (bloc) => bloc.add(FetchContentPageEvent()),
      expect: () => [isA<ContentPageLoading>(), isA<ContentPageSuccess>()],
    );

    tearDown(() => bloc.close());
  });
}
