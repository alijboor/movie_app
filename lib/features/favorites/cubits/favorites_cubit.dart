import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/managers/favorite_manager.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/favorites/cubits/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteManager favManager;

  FavoritesCubit() : favManager = FavoriteManager(), super(FavoritesInitial());

  void toggleFavorite(MovieEntity movie) async {
    await favManager.toggleFavorite(movie);

    emit(FavoritesLoaded());
  }
}
