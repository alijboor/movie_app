import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/favorites/cubits/favorites_cubit.dart';
import 'package:movie_app/features/favorites/cubits/favorites_state.dart';
import 'package:movie_app/features/home/widgets/movies_grid_builder.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final cubit = context.read<FavoritesCubit>();
        final favList = cubit.favManager.favoriteMovies;
        return state is FavoritesLoaded && favList.isEmpty
            ? Center(child: Text(LangKeys.emptyFavScreen))
            : MoviesGridBuilder.withoutLoadMore(
              movies: favList,
              toggleFav: cubit.toggleFavorite,
            );
      },
    );
  }
}
