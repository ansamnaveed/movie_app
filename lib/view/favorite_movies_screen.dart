import 'package:flutter/material.dart';
import 'package:movie_app/modal/md_movire.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = _getFavoriteMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          return ListTile(
            leading: Image.network(
              movie.posterUrl,
              width: 50,
            ),
            title: Text(movie.title),
            subtitle: Text(movie.releaseDate),
          );
        },
      ),
    );
  }

  List<Movie> _getFavoriteMovies() {
    // Retrieve favorite movies from local storage
    // Example implementation using shared_preferences
    final List<Movie> favoriteMovies = [];

    SharedPreferences.getInstance().then((prefs) {
      prefs.getKeys().forEach((key) {
        if (key.startsWith('movie_') && key.endsWith('_favorite')) {
          final title = key.substring(6, key.length - 9);
          final isFavorite = prefs.getBool(key) ?? false;

          favoriteMovies.add(Movie(
            title: title,
            releaseDate: '',
            overview: '',
            posterUrl: '',
            isFavorite: isFavorite,
          ));
        }
      });
    });

    return favoriteMovies;
  }
}
