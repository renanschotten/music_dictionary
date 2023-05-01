part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageFailure extends HomePageState {
  final String message;

  HomePageFailure({required this.message});
}

class HomePageSuccess extends HomePageState {
  final List<HomePageContent> response;
  HomePageSuccess({
    required this.response,
  });
}
