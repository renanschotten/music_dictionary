import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_dictionary/app/music_dictionary_app.dart';
import 'package:music_dictionary/firebase_options.dart';
import 'package:music_dictionary/app/di/injection_container.dart' as ic;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ic.init();
  await clearSharedPrefs();
  runApp(const MusicDictionaryApp());
}

Future<void> clearSharedPrefs() async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();
}
