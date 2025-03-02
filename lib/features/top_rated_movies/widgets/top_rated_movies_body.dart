import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/home/widgets/movies_grid_builder.dart';
import 'package:movie_app/features/top_rated_movies/cubits/top_rated_cubit.dart';
import 'package:movie_app/features/top_rated_movies/cubits/top_rated_state.dart';

class TopRatedMoviesBody extends StatefulWidget {
  const TopRatedMoviesBody({super.key});

  @override
  State<TopRatedMoviesBody> createState() => _TopRatedMoviesBodyState();
}

class _TopRatedMoviesBodyState extends State<TopRatedMoviesBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopRatedCubit>(context).loadTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        return state is TopRatedLoading
            ? const Center(child: CircularProgressIndicator())
            : state is TopRatedLoaded && state.movies.isNotEmpty
            ? MoviesGridBuilder.withoutLoadMore(movies: state.movies)
            : Center(child: Text(LangKeys.emptyMovies));
      },
    );
  }
}
