import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/movie_repository_impl.dart';

class RatingScreen extends StatefulWidget {
  final String movieId;

  const RatingScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State
{
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar Filme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecione sua avaliação:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Slider(
              value: _rating,
              min: 0,
              max: 10,
              divisions: 10,
              label: _rating.toString(),
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                bool success = await context.read<MovieRepositoryImpl>().addRating(widget.movieId, _rating);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Avaliação enviada com sucesso!'))
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao enviar a avaliação. Tente novamente.'))
                  );
                }
              },
              child: Text('Enviar Avaliação'),
            ),
          ],
        ),
      ),
    );
  }
}
