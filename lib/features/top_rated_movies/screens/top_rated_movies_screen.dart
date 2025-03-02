import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/top_rated_movies/cubits/top_rated_cubit.dart';
import 'package:movie_app/features/top_rated_movies/widgets/top_rated_movies_body.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(LangKeys.topRatedMovies)),
        body: TopRatedMoviesBody(),
      ),
    );
  }
}
