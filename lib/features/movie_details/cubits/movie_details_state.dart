import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}
class MovieDetailsLoaded extends MovieDetailsState {
  final MovieEntity movie;
  MovieDetailsLoaded(this.movie);
}
