import 'package:shared_preferences/shared_preferences.dart';

class Movie {
  final String title;
  final String releaseDate;
  final String overview;
  final String posterUrl;
  bool isFavorite;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterUrl,
    this.isFavorite = false,
  });

  Future<void> saveFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('movie_${title}_favorite', isFavorite);
  }

  Future<void> loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite = prefs.getBool('movie_${title}_favorite') ?? false;
  }
}
