import 'package:get_it/get_it.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/data/repositories/music_dictionary_repository_impl.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;
const mock = false;

Future<void> init() async {
  await _initSharedPref();
  if (mock) {
    getIt.registerLazySingleton<MusicDictionaryDatasource>(
      () => MockMusicDictionaryDatasource(),
    );
  } else {
    getIt.registerLazySingleton<MusicDictionaryDatasource>(
      () => FirestoreMusicDictionaryDatasource(),
    );
  }

  getIt.registerLazySingleton(
    () => SharedPrefsMusicDictionaryPersistence(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton<MusicDictionaryRepository>(
    () => MusicDictionaryRepositoryImpl(
      datasource: getIt<MusicDictionaryDatasource>(),
      persistence: getIt<SharedPrefsMusicDictionaryPersistence>(),
    ),
  );

  getIt.registerLazySingleton<MusicDictionaryService>(
    () => MusicDictionaryService(
      repository: getIt<MusicDictionaryRepository>(),
    ),
  );
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
