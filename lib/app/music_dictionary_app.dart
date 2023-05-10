import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/presentation/pages/content_page/content_page.dart';
import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/presentation/pages/home_page/home_page.dart';
import 'package:music_dictionary/presentation/pages/splash/splash_screen.dart';
import 'package:music_dictionary/shared/config/routes.dart';

class MusicDictionaryApp extends StatelessWidget {
  const MusicDictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (_) => getIt<HomePageBloc>()),
        BlocProvider<ContentPageBloc>(create: (_) => getIt<ContentPageBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: Routes.splash,
        routes: {
          Routes.splash: (_) => SplashScreen(),
          Routes.home: (_) => HomePage(),
          Routes.contentDetails: (context) => ContentPage(
                homePageContent: ModalRoute.of(context)?.settings.arguments
                    as HomePageContent,
              ),
        },
      ),
    );
  }
}
