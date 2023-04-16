import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MockMusicDictionaryService extends Mock
    implements MusicDictionaryService {}

void main() {
  late MusicDictionaryService service;
  late HomePageBloc bloc;
  final Failure failure = GenericFailure(message: 'message');
  final List<AppContent> homePageData = [
    AppContent(name: 'name', path: 'path')
  ];

  setUp(() {
    service = MockMusicDictionaryService();
    bloc = HomePageBloc(service: service);
  });
  group('HomePageBloc', () {
    blocTest<HomePageBloc, HomePageState>(
      'Should emit [HomePageLoading, HomePageFailure] when returned Failure',
      build: () => bloc,
      setUp: () => when(() => service.fetchHomePage()).thenAnswer(
        (_) => Future.value(Left(failure)),
      ),
      act: (bloc) => bloc.add(FetchHomePageEvent()),
      expect: () => [isA<HomePageLoading>(), isA<HomePageFailure>()],
    );

    blocTest<HomePageBloc, HomePageState>(
      'Should emit [HomePageLoading, HomePageSuccess] when returned Success from fetchData',
      build: () => bloc,
      setUp: () {
        when(() => service.fetchHomePage()).thenAnswer(
          (_) => Future.value(Right(homePageData)),
        );
        when(() => service.saveHomePageData(homePageData)).thenAnswer(
          (_) => Future.value(true),
        );
      },
      act: (bloc) => bloc.add(FetchHomePageEvent()),
      expect: () => [isA<HomePageLoading>(), isA<HomePageSuccess>()],
    );
    tearDown(() => bloc.close());
  });
}
