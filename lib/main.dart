import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favorites/cubits/favorites_cubit.dart';
import 'package:movie_app/core/managers/favorite_manager.dart';
import 'package:movie_app/features/home/cubits/home_cubit.dart';
import 'package:movie_app/features/favorites/screens/favorites_screen.dart';
import 'package:movie_app/features/top_rated_movies/screens/top_rated_movies_screen.dart';

import 'core/constants/lang_keys.dart' show LangKeys;
import 'features/home/screens/home_screen.dart' show HomeScreen;
import 'features/top_rated_movies/cubits/top_rated_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteManager().loadFavorites(); // Load favorites on app start

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => TopRatedCubit()),
      ],
      child: MaterialApp(
        title: LangKeys.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
    TopRatedMoviesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: LangKeys.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: LangKeys.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vertical_align_top),
            label: LangKeys.topRatedMovies,
          ),
        ],
      ),
    );
  }
}
