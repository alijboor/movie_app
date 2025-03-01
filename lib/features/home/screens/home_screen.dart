import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/lang_keys.dart';
import 'package:movie_app/features/home/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(LangKeys.home)),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.favorite, color: Colors.red, size: 35),
          onPressed: () {},
        ),
    );
  }
}
