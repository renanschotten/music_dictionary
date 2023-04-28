import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';

part 'content_page_event.dart';
part 'content_page_state.dart';

class ContentPageBloc extends Bloc<ContentPageEvent, ContentPageState> {
  final MusicDictionaryService service;
  late final List<Chord> chords;

  late final ValueNotifier<Chord> selectedChordNotifier;

  final ValueNotifier<int> selectedChordIndex = ValueNotifier<int>(0);

  Chord get selectedChord => selectedChordNotifier.value;

  void updateSelectedChord(int index) {
    selectedChordIndex.value = index;
    selectedChordNotifier.value = chords[index];
  }

  ContentPageBloc({required this.service}) : super(ContentPageInitial()) {
    on<FetchContentPageEvent>((event, emit) async {
      emit(ContentPageLoading());
      final response = await service.fetchChordsPage();
      emit(response.fold(
        (l) => ContentPageFailure(),
        (r) {
          chords = r;
          selectedChordNotifier = ValueNotifier<Chord>(r.first);
          return ContentPageSuccess(response: r);
        },
      ));
    });
  }
}
