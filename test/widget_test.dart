import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:f290_dsm_aula_05_abril_24/App.dart'; // Ajuste o caminho conforme necessário

void main() {
  testWidgets('App launches and shows TheMovieDB title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // Adicione aqui os providers necessários para o teste, como mock ou dummy providers
        ],
        child: const MaterialApp(
          home: App(),
        ),
      ),
    );

    // Verifique se o título na AppBar é 'TheMovieDB', que é o esperado na HomePage.
    expect(find.text('TheMovieDB'), findsOneWidget);

    // Adicione aqui mais verificações conforme necessário, como verificar a existência de certos widgets.
  });

  // Aqui você pode adicionar outros testes para diferentes partes do seu aplicativo.
}