import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';
import 'package:music_dictionary/shared/core/crashlytics_logging.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final MusicDictionaryService service;
  HomePageBloc({required this.service}) : super(HomePageInitial()) {
    on<FetchHomePageEvent>((event, emit) async {
      emit(HomePageLoading());
      final response = await service.fetchHomePage();
      emit(await response.fold(
        (l) {
          CrashlyticsLogging.instance.recordError(
            message: l.message,
            stackTrace: l.stackTrace,
          );
          return HomePageFailure(message: l.message ?? '');
        },
        (r) => HomePageSuccess(response: r),
      ));
    });
  }
}
