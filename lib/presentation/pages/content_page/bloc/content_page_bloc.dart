import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_dictionary/domain/entities/base_content.dart';
import 'package:music_dictionary/domain/services/music_dictionary_service.dart';

part 'content_page_event.dart';
part 'content_page_state.dart';

class ContentPageBloc extends Bloc<ContentPageEvent, ContentPageState> {
  final MusicDictionaryService service;
  late List<BaseContent> content;

  late ValueNotifier<BaseContent> selectedContentNotifier;

  final ValueNotifier<int> selectedContentIndex = ValueNotifier<int>(0);

  BaseContent get selectedContent => selectedContentNotifier.value;

  void updateSelectedChord(int index) {
    selectedContentIndex.value = index;
    selectedContentNotifier.value = content[index];
  }

  ContentPageBloc({required this.service}) : super(ContentPageInitial()) {
    on<FetchContentPageEvent>((event, emit) async {
      emit(ContentPageLoading());
      final response = await service.fetchContent(id: event.id);
      emit(response.fold(
        (l) => ContentPageFailure(),
        (r) {
          content = r;
          selectedContentNotifier = ValueNotifier<BaseContent>(r.first);
          return ContentPageSuccess(response: r);
        },
      ));
    });
  }
}
