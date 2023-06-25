import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/modal/md_movire.dart';

class MovieService {
  static const String apiKey = '9af9e4bfe9b8c3151563eadbb9c2e22e';
  static const String apiAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YWY5ZTRiZmU5YjhjMzE1MTU2M2VhZGJiOWMyZTIyZSIsInN1YiI6IjY0OTczY2I3NmY0M2VjMDBlMjdkODgxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QGKlbumiX7wpsb2x6O-Qu0WkaUra1gnM3Tz8Iz4FXR4';

  Future<List<Movie>> fetchMovies() async {
    final url =
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Movie> movies = [];

      for (var item in jsonData['results']) {
        movies.add(Movie(
          title: item['title'],
          releaseDate: item['release_date'],
          overview: item['overview'],
          posterUrl: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
        ));
      }

      return movies;
    } else {
      throw Exception('Failed to fetch movies.');
    }
  }
}
