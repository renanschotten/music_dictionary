import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryRepository {
  Future<Either<Failure, List<AppContent>>> fetchHomePage();

  Future<bool> saveHomePageData(List<AppContent> homePageData);
}
