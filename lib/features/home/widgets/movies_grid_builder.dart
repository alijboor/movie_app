import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/cubits/home_cubit.dart';
import 'package:movie_app/features/home/cubits/home_state.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/home/widgets/poster_image.dart';
import 'rating_favorite_action_row.dart';

class MoviesGridBuilder extends StatelessWidget {
  const MoviesGridBuilder({required this.movies, this.toggleFav, super.key})
    : _withLoadMore = true;

  const MoviesGridBuilder.withoutLoadMore({
    required this.movies,
    this.toggleFav,
    super.key,
  }) : _withLoadMore = false;

  final List<MovieEntity> movies;
  final bool _withLoadMore;

  final ValueChanged<MovieEntity>? toggleFav;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return GridView.builder(
          controller: _withLoadMore ? cubit.scrollController : null,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.54,
          ),
          itemCount:
              movies.length +
              ((_withLoadMore && state is HomeLoadingMore) ? 1 : 0),
          itemBuilder: (context, index) {
            if (_withLoadMore && state is HomeLoadingMore) {
              return const Center(child: CircularProgressIndicator());
            }

            final movie = movies[index];

            return InkWell(
              onTap: () => cubit.toDetailScreen(context, movie),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PosterImage(posterImagePath: movie.posterPath),
                    const SizedBox(height: 5.0),
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingFavoriteActionRow(
                      movie: movie,
                      isFav: cubit.favManager.isFavorite,
                      toggleFav: toggleFav ?? cubit.toggleFavState,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
