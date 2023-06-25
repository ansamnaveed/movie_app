import 'package:flutter/material.dart';
import 'package:movie_app/view/favorite_movies_screen.dart';
import 'package:movie_app/view/movie_list_widget.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MovieListWidget(),
        '/favorites': (context) => FavoriteMoviesScreen(),
      },
    );
  }
}
