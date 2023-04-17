import 'dart:convert';

import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/data/models/chord_model.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MusicDictionaryPersistence {
  Future<bool> saveHomePageData(List<AppContent> homePageData);
  Future<List<AppContentModel>?> fetchHomePage();
  Future<List<ChordModel>?> fetchChordsPage();
}

class SharedPrefsMusicDictionaryPersistence
    implements MusicDictionaryPersistence {
  late SharedPreferences sharedPreferences;

  @override
  Future<bool> saveHomePageData(List<AppContent> homePageData) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> map = homePageData
          .map((e) => AppContentModel.fromEntity(e).toMap())
          .toList();
      String json = jsonEncode(map);
      await sharedPreferences.setString(LocalStorageKeys.homePageData, json);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<AppContentModel>?> fetchHomePage() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      final json = sharedPreferences.getString(
        LocalStorageKeys.homePageData,
      );
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
      sharedPreferences = await SharedPreferences.getInstance();
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
