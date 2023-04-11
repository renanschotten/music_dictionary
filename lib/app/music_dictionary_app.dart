import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/presentation/pages/home_page/home_page.dart';
import 'package:music_dictionary/shared/config/routes.dart';

class MusicDictionaryApp extends StatelessWidget {
  const MusicDictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc(
            service: getIt<MusicDictionaryService>(),
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (_) => HomePage(),
        },
      ),
    );
  }
}
