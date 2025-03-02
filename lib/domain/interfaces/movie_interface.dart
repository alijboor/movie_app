
import 'package:movie_app/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class MovieInterface {
  Future<BasePaginatedResponseEntity<MovieEntity>?> fetchMovies(int page);
  Future<BasePaginatedResponseEntity<MovieEntity>?> searchMovies(String query,
      {int? page});
  Future<BasePaginatedResponseEntity<MovieEntity>?> fetchTopRatedMovies(int page);

}
