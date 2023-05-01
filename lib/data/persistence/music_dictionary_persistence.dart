import 'dart:convert';

import 'package:music_dictionary/data/models/home_page_content_model.dart';
import 'package:music_dictionary/data/models/base_content_model.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MusicDictionaryPersistence {
  Future<bool> saveAppData({required String key, required String json});
  Future<List<HomePageContentModel>?> fetchHomePage();
  Future<List<BaseContentModel>?> fetchContent({required String id});
}

class SharedPrefsMusicDictionaryPersistence
    implements MusicDictionaryPersistence {
  SharedPrefsMusicDictionaryPersistence({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<bool> saveAppData({
    required String key,
    required String json,
  }) async {
    try {
      return await sharedPreferences.setString(key, json);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<HomePageContentModel>?> fetchHomePage() async {
    try {
      final json = sharedPreferences.getString(LocalStorageKeys.homePageData);
      if (json == null || json.isEmpty) return null;
      final List response = jsonDecode(json);
      final List<HomePageContentModel> homePageData =
          response.map((e) => HomePageContentModel.fromMap(e)).toList();
      return homePageData;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<BaseContentModel>?> fetchContent({required String id}) async {
    try {
      final json = sharedPreferences.getString(id);
      if (json == null || json.isEmpty) return null;
      final List response = jsonDecode(json);
      final List<BaseContentModel> content =
          response.map((e) => BaseContentModel.fromMap(e)).toList();
      return content;
    } catch (e) {
      return null;
    }
  }
}
