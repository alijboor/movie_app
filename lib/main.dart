import 'package:flutter/material.dart';

import 'core/constants/lang_keys.dart' show LangKeys;
import 'features/home/screens/home_screen.dart' show HomeScreen;

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LangKeys.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
