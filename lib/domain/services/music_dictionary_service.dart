import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MusicDictionaryService {
  MusicDictionaryService({required this.repository});

  final MusicDictionaryRepository repository;
  bool returnedCached = false;
  Future<Either<Failure, List<AppContent>>> fetchHomePage() async {
    final response = await repository.fetchCachedHomePage();
    if (response != null) {
      returnedCached = true;
      return Right(response);
    }
    return await repository.fetchHomePage();
  }

  Future<bool> saveHomePageData(List<AppContent> homePageData) async {
    if (returnedCached) return true;
    return await repository.saveHomePageData(homePageData);
  }

  Future<Either<Failure, List<Chord>>> fetchChordsPage() async {
    final response = await repository.fetchCachedChordsPage();
    if (response != null) {
      returnedCached = true;
      return Right(response);
    }
    return await repository.fetchChordsPage();
  }
}
