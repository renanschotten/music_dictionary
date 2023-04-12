part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class FetchHomePageEvent extends HomePageEvent {}

class SaveHomePageDataEvent extends HomePageEvent {
  final List<AppContent> homePageData;
  SaveHomePageDataEvent({
    required this.homePageData,
  });
}
