import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/managers/favorite_manager.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movie_details/cubits/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieEntity movie;
  final FavoriteManager favManager;

  MovieDetailsCubit(this.movie)
    : favManager = FavoriteManager(),
      super(MovieDetailsInitial());

  void loadMovieDetails(MovieEntity movie) {
    emit(MovieDetailsLoaded(movie));
  }

  void rateMovie(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rate Movie'),
            content: const Text('Feature coming soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void toggleFavState(MovieEntity movie) async {
    await favManager.toggleFavorite(movie);
    emit(MovieDetailsLoaded(movie));
  }
}
