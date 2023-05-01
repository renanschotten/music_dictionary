import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryRepository {
  Future<Either<Failure, List<HomePageContent>>> fetchHomePage();

  Future<List<HomePageContent>?> fetchCachedHomePage();

  Future<bool> saveAppData({required String key, required String json});

  Future<Either<Failure, List<BaseContent>>> fetchContent({
    required String id,
  });

  Future<List<BaseContent>?> fetchCachedContent({required String id});
}
