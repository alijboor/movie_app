import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/storage_keys.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/features/favorites/screens/favorites_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteManager {
  static final FavoriteManager _singleton = FavoriteManager._internal();

  factory FavoriteManager() {
    return _singleton;
  }

  FavoriteManager._internal();

  List<MovieEntity> _favoriteMovies = [];

  List<MovieEntity> get favoriteMovies => _favoriteMovies;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(StorageKeys.favMovies) ?? [];
    _favoriteMovies =
        favorites.map((movie) {
          var item = json.decode(movie);
          return MovieEntity.fromJson(item);
        }).toList();
  }

  Future<void> toggleFavorite(MovieEntity movie) async {
    final prefs = await SharedPreferences.getInstance();

    if (isFavorite(movie)) {
      _favoriteMovies.removeWhere((e) => e.id == movie.id);
    } else {
      _favoriteMovies.add(movie);
    }
    final favoriteStrings =
        _favoriteMovies.map((movie) => json.encode(movie.toJson())).toList();
    prefs.setStringList(StorageKeys.favMovies, favoriteStrings);
  }

  bool isFavorite(MovieEntity movie) =>
      _favoriteMovies.any((e) => e.id == movie.id);

  void toFavScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritesScreen()),
    );
  }
}
