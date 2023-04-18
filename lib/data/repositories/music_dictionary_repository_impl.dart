import 'package:dartz/dartz.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
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
  Future<Either<Failure, List<AppContent>>> fetchHomePage() async {
    return await _datasource.fetchHomePage();
  }

  @override
  Future<List<AppContent>?> fetchCachedHomePage() async {
    return await _persistence.fetchHomePage();
  }

  @override
  Future<List<Chord>?> fetchCachedChordsPage() async {
    return await _persistence.fetchChordsPage();
  }

  @override
  Future<Either<Failure, List<Chord>>> fetchChordsPage() {
    return _datasource.fetchChordsPage();
  }

  @override
  Future<bool> saveAppData({required String key, required String json}) async {
    return await _persistence.saveAppData(key: key, json: json);
  }
}
