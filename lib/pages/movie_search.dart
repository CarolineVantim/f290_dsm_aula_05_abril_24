import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/movie_model.dart';
import '../repositories/movie_repository_impl.dart';
import 'movie_details.dart'; // Certifique-se de que esta página está importada

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MovieModel> _movies = []; // Lista completa de filmes
  List<MovieModel> _filteredMovies = []; // Filmes filtrados

  @override
  void initState() {
    super.initState();
    _loadMovies(); // Carregar os filmes na inicialização
  }

  void _loadMovies() async {
    var movies = await context.read<MovieRepositoryImpl>().getUpcoming();
    setState(() {
      _movies = movies;
      _filteredMovies = movies;
    });
  }

  void _filterMovies() {
    String query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      List<MovieModel> filteredList = _movies.where((movie) {
        return movie.title.toLowerCase().contains(query);
      }).toList();
      setState(() {
        _filteredMovies = filteredList;
      });
    } else {
      setState(() {
        _filteredMovies = _movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movies"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for movies...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (text) => _filterMovies(),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = _filteredMovies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text('Rating: ${movie.voteAverage.toString()}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}