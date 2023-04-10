import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MusicDictionaryService {
  MusicDictionaryService({required this.repository});

  final MusicDictionaryRepository repository;

  Future<Either<Failure, List<AppContent>>> fetchHomePage() async {
    return await repository.fetchHomePage();
  }

  Future<bool> saveHomePageData(List<AppContent> homePageData) async {
    return await repository.saveHomePageData(homePageData);
  }
}
