import 'package:flutter/material.dart';
import '../model/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              movie.getPostPathUrl(),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Release Date: ${movie.releaseDate}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 16),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  // Add more details here like ratings, cast, etc.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}