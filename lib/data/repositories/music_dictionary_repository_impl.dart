import 'package:dartz/dartz.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MusicDictionaryRepositoryImpl implements MusicDictionaryRepository {
  MusicDictionaryRepositoryImpl({
    required MusicDictionaryDatasource datasource,
    required MusicDictionaryPersistence persistence,
  })  : _datasource = datasource,
        _persistence = persistence;

  final MusicDictionaryDatasource _datasource;
  final MusicDictionaryPersistence _persistence;

  @override
  Future<Either<Failure, List<HomePageContent>>> fetchHomePage() async {
    return await _datasource.fetchHomePage();
  }

  @override
  Future<List<HomePageContent>?> fetchCachedHomePage() async {
    return await _persistence.fetchHomePage();
  }

  @override
  Future<List<BaseContent>?> fetchCachedContent({required String id}) async {
    return await _persistence.fetchContent(id: id);
  }

  @override
  Future<Either<Failure, List<BaseContent>>> fetchContent({
    required String id,
  }) {
    return _datasource.fetchContent(id: id);
  }

  @override
  Future<bool> saveAppData({required String key, required String json}) async {
    return await _persistence.saveAppData(key: key, json: json);
  }
}
