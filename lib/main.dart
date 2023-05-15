import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/app/music_dictionary_app.dart';
import 'package:music_dictionary/firebase_options.dart';
import 'package:music_dictionary/shared/constants/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_dictionary/app/di/injection_container.dart' as ic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ic.init();
  await shouldClearLocalStorage();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterError.onError = (details) =>
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance
        .recordError(exception, stackTrace, fatal: true);
    return true;
  };
  MobileAds.instance.initialize();
  runApp(const MusicDictionaryApp());
}

Future<void> shouldClearLocalStorage() async {
  final sp = getIt<SharedPreferences>();
  final int now = DateTime.now().millisecondsSinceEpoch;
  final int sevenDaysInMilliseconds = Duration(days: 7).inMilliseconds;
  var cacheDate = sp.getInt(LocalStorageKeys.cacheDate);

  if (cacheDate == null) {
    sp.setInt(LocalStorageKeys.cacheDate, now);
  } else if ((now - cacheDate) >= sevenDaysInMilliseconds) {
    if (await checkInternetConnection()) {
      await clearSharedPrefs();
      sp.setInt(LocalStorageKeys.cacheDate, now);
    }
  }
}

Future<void> clearSharedPrefs() async {
  final sp = getIt<SharedPreferences>();
  sp.clear();
}

Future<bool> checkInternetConnection() async {
  return await InternetConnectionChecker().hasConnection;
}
