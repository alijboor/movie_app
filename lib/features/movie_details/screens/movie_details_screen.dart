import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movie_details/cubits/movie_details_cubit.dart';
import 'package:movie_app/features/movie_details/widgets/movie_details_body.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsCubit(movie),
      child: Scaffold(
        appBar: AppBar(title: Text(movie.title), leading: const BackButton()),
        body: MovieDetailsBody(),
      ),
    );
  }
}
