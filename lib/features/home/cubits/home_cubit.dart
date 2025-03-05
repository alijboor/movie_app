import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/managers/favorite_manager.dart';
import 'package:movie_app/features/home/cubits/home_state.dart';
import 'package:movie_app/features/home/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/home/data/repositories/movie_data_impl.dart';
import 'package:movie_app/features/movie_details/screens/movie_details_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRemoteDataSourceImpl repo;
  final FavoriteManager favManager;

  final TextEditingController searchController;
  final ScrollController scrollController;

  BasePaginatedResponseEntity<MovieEntity>? paginated;

  HomeCubit()
    : searchController = TextEditingController(),
      scrollController = ScrollController(),
      favManager = FavoriteManager(),
      repo = MovieRemoteDataSourceImpl(),
      super(HomeInitial()) {
    scrollController.addListener(_onScroll);
    loadMovies();
  }

  void loadMovies({int page = 1}) async {
    emit(HomeLoading());
    try {
      await favManager.loadFavorites(); // Load favorites first

      paginated = await repo.fetchMovies(page);
      final movies =
          paginated?.results?.whereType<MovieEntity>().toList() ?? [];
      emit(
        HomeLoaded(
          movies: movies,
          currentPage: page,
          hasMore: page < (paginated?.totalPages ?? 1),
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void loadMoreMovies() async {
    final currentState = state;
    if (currentState is HomeLoaded &&
        !currentState.isFetchingMore &&
        currentState.hasMore) {
      emit(
        HomeLoaded(
          movies: currentState.movies,
          currentPage: currentState.currentPage,
          hasMore: currentState.hasMore,
          isFetchingMore: true,
        ),
      );
      emit(HomeLoadingMore());


      try {
        final nextPage = currentState.currentPage + 1;
        final newPaginated = await repo.fetchMovies(nextPage);
        final newMovies =
            newPaginated?.results?.whereType<MovieEntity>().toList() ?? [];

        emit(
          HomeLoaded(
            movies: [...currentState.movies, ...newMovies],
            currentPage: nextPage,
            hasMore: nextPage < (newPaginated?.totalPages ?? 1),
            isFetchingMore: false,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }

  void searchMovies(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    emit(HomeLoading());
    try {
      paginated = await repo.searchMovies(query, page: 1);
      final movies =
          paginated?.results?.whereType<MovieEntity>().toList() ?? [];
      emit(
        HomeLoaded(
          movies: movies,
          currentPage: 1,
          hasMore: false,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void clearSearch() {
    searchController.clear();
    emit(HomeSearchClear());
    loadMovies();
  }

  void toggleFavState(MovieEntity movie) async {
    await favManager.toggleFavorite(movie);
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeFavUpdate());

      emit(
        HomeLoaded(
          movies: currentState.movies,
          currentPage: currentState.currentPage,
          hasMore: currentState.hasMore,
          isFetchingMore: currentState.isFetchingMore,
        ),
      );
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      loadMoreMovies();
    }
  }

  void toDetailScreen(BuildContext context, MovieEntity movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    searchController.dispose();
    return super.close();
  }
}
