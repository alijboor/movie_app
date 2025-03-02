import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/favorites/cubits/favorites_cubit.dart';
import 'package:movie_app/features/favorites/widgets/favorites_body.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LangKeys.favScreen),
        ),
        body: FavoritesBody(),
      ),
    );
  }
}
