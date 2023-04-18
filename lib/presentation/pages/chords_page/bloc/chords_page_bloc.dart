import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';

part 'chords_page_event.dart';
part 'chords_page_state.dart';

class ChordsPageBloc extends Bloc<ChordsPageEvent, ChordsPageState> {
  final MusicDictionaryService service;
  ChordsPageBloc({required this.service}) : super(ChordsPageInitial()) {
    on<FetchChordsPageEvent>((event, emit) async {
      emit(ChordsPageLoading());
      final response = await service.fetchChordsPage();
      emit(response.fold(
        (l) => ChordsPageFailure(),
        (r) => ChordsPageSuccess(response: r),
      ));
    });
  }
}
