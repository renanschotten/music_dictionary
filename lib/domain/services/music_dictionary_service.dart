import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

class MusicDictionaryService {
  MusicDictionaryService({required this.repository});

  final MusicDictionaryRepository repository;
  Future<Either<Failure, List<HomePageContent>>> fetchHomePage() async {
    final cachedResponse = await repository.fetchCachedHomePage();
    if (cachedResponse != null) return Right(cachedResponse);
    final response = await repository.fetchHomePage();
    response.fold(
      (l) => null,
      (r) async {
        List<Map<String, dynamic>> mapList = [];
        r.forEach((e) => mapList.add(e.toMap()));
        final json = jsonEncode(mapList);
        await saveAppData(
          key: LocalStorageKeys.homePageData,
          json: json,
        );
      },
    );
    return response;
  }

  Future<bool> saveAppData({required String key, required String json}) async {
    return await repository.saveAppData(key: key, json: json);
  }

  Future<Either<Failure, List<BaseContent>>> fetchContent({
    required String id,
  }) async {
    final cachedResponse = await repository.fetchCachedContent(id: id);
    if (cachedResponse != null) return Right(cachedResponse);
    final response = await repository.fetchContent(id: id);
    response.fold(
      (l) => null,
      (r) async {
        List<Map<String, dynamic>> mapList = [];
        r.forEach((e) => mapList.add(e.toMap()));
        final json = jsonEncode(mapList);
        await saveAppData(
          key: LocalStorageKeys.chordsPageData,
          json: json,
        );
      },
    );
    return response;
  }
}
