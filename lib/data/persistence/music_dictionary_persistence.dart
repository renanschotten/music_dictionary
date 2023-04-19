import 'dart:convert';

import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/data/models/chord_model.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MusicDictionaryPersistence {
  Future<bool> saveAppData({required String key, required String json});
  Future<List<AppContentModel>?> fetchHomePage();
  Future<List<ChordModel>?> fetchChordsPage();
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
  Future<List<AppContentModel>?> fetchHomePage() async {
    try {
      final json = sharedPreferences.getString(LocalStorageKeys.homePageData);
      if (json == null || json.isEmpty) return null;
      final List response = jsonDecode(json);
      final List<AppContentModel> homePageData =
          response.map((e) => AppContentModel.fromMap(e)).toList();
      return homePageData;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ChordModel>?> fetchChordsPage() async {
    try {
      final json = sharedPreferences.getString(LocalStorageKeys.chordsPageData);
      if (json == null || json.isEmpty) return null;
      final List response = jsonDecode(json);
      final List<ChordModel> chordsPageData =
          response.map((e) => ChordModel.fromMap(e)).toList();
      return chordsPageData;
    } catch (e) {
      return null;
    }
  }
}
