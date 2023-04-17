part of 'chords_page_bloc.dart';

@immutable
abstract class ChordsPageState {}

class ChordsPageInitial extends ChordsPageState {}

class ChordsPageLoading extends ChordsPageState {}

class ChordsPageFailure extends ChordsPageState {}

class ChordsPageSuccess extends ChordsPageState {
  final List<Chord> response;

  ChordsPageSuccess({required this.response});
}
