import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'services/http_manager.dart';
import 'repositories/movie_repository_impl.dart';
import 'App.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      Provider<Dio>(
        create: (_) => Dio(),
      ),
      Provider<HttpManager>(
        create: (context) => HttpManager(dio: context.read<Dio>()),
      ),
      Provider<MovieRepositoryImpl>(
        create: (context) => MovieRepositoryImpl(httpManager: context.read<HttpManager>()),
      ),
    ],
    child: const App(),
  ));
}