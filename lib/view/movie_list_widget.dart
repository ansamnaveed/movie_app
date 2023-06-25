import 'package:flutter/material.dart';
import 'package:movie_app/modal/md_movire.dart';
import 'package:movie_app/services/movie_service.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = MovieService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/favorites");
            },
            icon: Icon(
              Icons.favorite_rounded,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final movies = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getGridColumnsCount(context),
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieItemWidget(movie: movie);
              },
            );
          }
        },
      ),
    );
  }

  int _getGridColumnsCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 3; // Three columns for larger screens
    } else if (screenWidth > 400) {
      return 2; // Two columns for medium-sized screens
    } else {
      return 1; // One column for small screens
    }
  }
}

class MovieItemWidget extends StatefulWidget {
  final Movie movie;

  const MovieItemWidget({required this.movie});

  @override
  State<MovieItemWidget> createState() => _MovieItemWidgetState();
}

class _MovieItemWidgetState extends State<MovieItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            widget.movie.posterUrl,
            fit: BoxFit.cover,
            height: 125,
          ),
          ListTile(
            title: Text(widget.movie.title),
            subtitle: Text(widget.movie.releaseDate),
            trailing: IconButton(
              icon: Icon(
                widget.movie.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  widget.movie.isFavorite = !widget.movie.isFavorite;
                  widget.movie.saveFavoriteStatus();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
