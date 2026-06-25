import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obras = context.watch<ObraProvider>().obras;

    final totalObras = obras.length;

    final totalCapitulos = obras.fold<int>(
      0,
      (total, obra) => total + obra.capitulos.length,
    );

    final totalVisualizacoes = obras.fold<int>(
      0,
      (total, obra) => total + obra.visualizacoes,
    );

    final totalFavoritos = obras.fold<int>(
      0,
      (total, obra) => total + obra.favoritos,
    );

    final mediaAvaliacoes = obras.isEmpty
        ? 0.0
        : obras.fold<double>(
              0,
              (total, obra) => total + obra.avaliacao,
            ) /
            obras.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              'Obras Publicadas',
              totalObras.toString(),
              Icons.menu_book,
            ),
            _card(
              'Capítulos',
              totalCapitulos.toString(),
              Icons.library_books,
            ),
            _card(
              'Visualizações',
              totalVisualizacoes.toString(),
              Icons.remove_red_eye,
            ),
            _card(
              'Favoritos',
              totalFavoritos.toString(),
              Icons.favorite,
            ),
            _card(
              'Média das Avaliações',
              mediaAvaliacoes.toStringAsFixed(1),
              Icons.star,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
    String titulo,
    String valor,
    IconData icone,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icone,
          size: 32,
        ),
        title: Text(titulo),
        trailing: Text(
          valor,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}