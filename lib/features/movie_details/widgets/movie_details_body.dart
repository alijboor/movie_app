import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/api_routes.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/home/widgets/rating_favorite_action_row.dart';
import 'package:movie_app/features/movie_details/cubits/movie_details_cubit.dart';
import 'package:movie_app/features/movie_details/cubits/movie_details_state.dart';

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        final cubit = context.read<MovieDetailsCubit>();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${ApiRoutes.imageRoute}${cubit.movie.posterPath}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.movie.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingFavoriteActionRow(
                      movie: cubit.movie,
                      isFav: cubit.favManager.isFavorite,
                      toggleFav: cubit.toggleFavState,
                    ),
                    _space,
                    Text('${LangKeys.releaseDate}: ${cubit.movie.releaseDate}'),
                    _space,
                    Text(cubit.movie.overview),
                    _space,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get _space => const SizedBox(height: 15.0);
}
