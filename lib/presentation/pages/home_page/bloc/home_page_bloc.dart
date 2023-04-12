import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_dictionary/domain/entities/app_content.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final MusicDictionaryService service;
  HomePageBloc({required this.service}) : super(HomePageInitial()) {
    on<FetchHomePageEvent>((event, emit) async {
      emit(HomePageLoading());
      final response = await service.fetchHomePage();
      emit(await response.fold(
        (l) => HomePageFailure(message: l.message!),
        (r) {
          //add(SaveHomePageDataEvent(homePageData: r));
          service.saveHomePageData(r);
          return HomePageSuccess(response: r);
        },
      ));
    });

    on<SaveHomePageDataEvent>((event, emit) async {
      await service.saveHomePageData(event.homePageData);
    });
  }
}
