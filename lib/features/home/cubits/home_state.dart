import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}
class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoadingMore extends HomeState {}
class HomeSearchClear extends HomeState {}
class HomeFavUpdate extends HomeState {}


class HomeLoaded extends HomeState {
  final List<MovieEntity> movies;
  final int currentPage;
  final bool hasMore;
  final bool isFetchingMore;

  const HomeLoaded({
    required this.movies,
    required this.currentPage,
    required this.hasMore,
    required this.isFetchingMore,
  });
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}

