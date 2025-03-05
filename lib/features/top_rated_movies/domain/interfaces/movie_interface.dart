import 'package:movie_app/features/home/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';

abstract class TopRatedMoviesInterface {

  Future<BasePaginatedResponseEntity<MovieEntity>?> fetchTopRatedMovies(
    int page
  );
}
