part of 'content_page_bloc.dart';

@immutable
abstract class ContentPageEvent {}

class FetchContentPageEvent extends ContentPageEvent {
  final String id;
  FetchContentPageEvent({
    required this.id,
  });
}
