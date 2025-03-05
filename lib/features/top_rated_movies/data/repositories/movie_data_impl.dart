import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/api_routes.dart';
import 'package:movie_app/core/services/dialog_service.dart';
import 'package:movie_app/features/home/domain/entities/base_paginated_response_entity.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/top_rated_movies/domain/interfaces/movie_interface.dart';

class TopRatedMoviesRemoteDataSourceImpl implements TopRatedMoviesInterface {
  final http.Client client;

  TopRatedMoviesRemoteDataSourceImpl() : client = http.Client();

  @override
  Future<BasePaginatedResponseEntity<MovieEntity>?> fetchTopRatedMovies(
    int page,
  ) async {
    final response = await client.get(
      Uri.parse('${ApiRoutes.movieTopRated}&page=$page'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BasePaginatedResponseEntity<MovieEntity>.fromJson(
        data,
        (movie) => MovieEntity.fromJson(movie),
      );
    }
    DialogService().showErrorDialog(response.reasonPhrase ?? '');
    return null;
  }
}
