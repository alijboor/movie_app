import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/managers/favorite_manager.dart';
import 'package:movie_app/features/home/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/top_rated_movies/cubits/top_rated_state.dart';
import 'package:movie_app/features/top_rated_movies/data/repositories/movie_data_impl.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final FavoriteManager favManager;
  final TopRatedMoviesRemoteDataSourceImpl repo;
  BasePaginatedResponseEntity<MovieEntity>? paginated;

  TopRatedCubit()
    : favManager = FavoriteManager(),
      repo = TopRatedMoviesRemoteDataSourceImpl(),

      super(TopRatedInitial());

  void loadTopRatedMovies({int page = 1}) async {
    emit(TopRatedLoading());
    try {
      await favManager.loadFavorites(); // Load favorites first

      paginated = await repo.fetchTopRatedMovies(page);
      final movies =
          paginated?.results?.whereType<MovieEntity>().toList() ?? [];
      emit(TopRatedLoaded(movies: movies));
    } catch (e) {
      emit(TopRatedError(e.toString()));
    }
  }

  void toggleFavorite(MovieEntity movie) async {
    await favManager.toggleFavorite(movie);
    final movies = paginated?.results?.whereType<MovieEntity>().toList() ?? [];
    emit(TopRatedFavUpdate());

    emit(TopRatedLoaded(movies: movies));
  }
}
