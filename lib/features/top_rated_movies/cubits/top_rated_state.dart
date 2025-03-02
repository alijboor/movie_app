import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object?> get props => [];
}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}
class TopRatedFavUpdate extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<MovieEntity> movies;

  const TopRatedLoaded({required this.movies});
}

class TopRatedError extends TopRatedState {
  final String message;
  const TopRatedError(this.message);
}
