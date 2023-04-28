part of 'content_page_bloc.dart';

@immutable
abstract class ContentPageState {}

class ContentPageInitial extends ContentPageState {}

class ContentPageLoading extends ContentPageState {}

class ContentPageFailure extends ContentPageState {}

class ContentPageSuccess extends ContentPageState {
  final List<Chord> response;

  ContentPageSuccess({required this.response});
}
