import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/entities/chords.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryRepository {
  Future<Either<Failure, List<AppContent>>> fetchHomePage();

  Future<List<AppContent>?> fetchCachedHomePage();

  Future<bool> saveHomePageData(List<AppContent> homePageData);

  Future<Either<Failure, List<Chord>>> fetchChordsPage();

  Future<List<Chord>?> fetchCachedChordsPage();
}
