import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/home/cubits/home_cubit.dart';
import 'package:movie_app/features/home/cubits/home_state.dart';
import 'package:movie_app/features/home/widgets/movies_grid_builder.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cubit.searchController,
                decoration: InputDecoration(
                  hintText: LangKeys.searchHint,
                  border: const OutlineInputBorder(),
                  suffixIcon:
                      cubit.searchController.text.isEmpty
                          ? const SizedBox()
                          : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: cubit.clearSearch,
                          ),
                ),
                onChanged: cubit.searchMovies,
              ),
            ),
            Expanded(
              child:
                  state is HomeLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state is HomeLoaded && state.movies.isNotEmpty
                      ? MoviesGridBuilder(movies: state.movies)
                      : Center(child: Text(LangKeys.emptyMovies)),
            ),
          ],
        );
      },
    );
  }
}
