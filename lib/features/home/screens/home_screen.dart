import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/home/cubits/home_cubit.dart';
import 'package:movie_app/features/home/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(LangKeys.home)),
        body: const HomeBody(),
      ),
    );
  }
}
