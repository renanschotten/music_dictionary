import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:music_dictionary/data/datasources/music_dictionary_datasource.dart';
import 'package:music_dictionary/data/persistence/music_dictionary_persistence.dart';
import 'package:music_dictionary/data/repositories/music_dictionary_repository_impl.dart';
import 'package:music_dictionary/domain/repositories/music_dictionary_repository.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/shared/core/ads/ad_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;
const mock = false;

Future<void> init() async {
  //ASYNC DEPENDENCIES
  await _initSharedPref();
  await _initFirebaseFirestore();

  //DATASOURCES
  if (mock) {
    getIt.registerLazySingleton<MusicDictionaryDatasource>(
      () => MockMusicDictionaryDatasource(),
    );
  } else {
    getIt.registerLazySingleton<MusicDictionaryDatasource>(
      () => FirestoreMusicDictionaryDatasource(
        firestore: getIt<FirebaseFirestore>(),
      ),
    );
  }

  //PERSISTENCE
  getIt.registerLazySingleton(
    () => SharedPrefsMusicDictionaryPersistence(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  //REPOSITORIES
  getIt.registerLazySingleton<MusicDictionaryRepository>(
    () => MusicDictionaryRepositoryImpl(
      datasource: getIt<MusicDictionaryDatasource>(),
      persistence: getIt<SharedPrefsMusicDictionaryPersistence>(),
    ),
  );

  //SERVICES
  getIt.registerLazySingleton<MusicDictionaryService>(
    () => MusicDictionaryService(
      repository: getIt<MusicDictionaryRepository>(),
    ),
  );

  //BLOCS
  getIt.registerLazySingleton<HomePageBloc>(
    () => HomePageBloc(
      service: getIt<MusicDictionaryService>(),
    ),
  );

  getIt.registerLazySingleton<ContentPageBloc>(
    () => ContentPageBloc(
      service: getIt<MusicDictionaryService>(),
    ),
  );

  getIt.registerFactory<AdController>(() => AdController());
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

Future<void> _initFirebaseFirestore() async {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  getIt.registerLazySingleton<FirebaseFirestore>(() => instance);
}
