import 'package:flutter/material.dart';
import 'package:projeto_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UserProvider>().usuario;

    final minhasObras =
        context.watch<ObraProvider>().obrasDoAutor(usuario!.uid);

    for (final obra in context.read<ObraProvider>().obras) {
      debugPrint(
        '${obra.titulo} | autorId=${obra.autorId}',
      );
    }

    for (final obra in context.watch<ObraProvider>().obras) {
      debugPrint(
        '${obra.titulo} -> autorId=${obra.autorId}',
      );
    }

    debugPrint(
      'Minhas obras: ${minhasObras.length}',
    );

    for (final obra in minhasObras) {
      debugPrint(
        '${obra.titulo} | '
        'Views: ${obra.visualizacoes} | '
        'Avaliações: ${obra.totalAvaliacoes} | '
        'Nota: ${obra.avaliacao}',
      );
    }

    final totalObras = minhasObras.length;

    final totalVisualizacoes = minhasObras.fold(
      0,
      (total, obra) => total + obra.visualizacoes,
    );

    final totalFavoritos = minhasObras.fold(
      0,
      (total, obra) => total + obra.favoritos,
    );

    final totalCapitulos = minhasObras.fold(
      0,
      (total, obra) => total + obra.capitulos.length,
    );

    double mediaAvaliacoes = 0;

    if (minhasObras.isNotEmpty) {
      double soma = 0;

      for (final obra in minhasObras) {
        soma += obra.avaliacao;
      }

      mediaAvaliacoes = soma / minhasObras.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
      ),
      body: SingleChildScrollView(
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
            const SizedBox(height: 24),
            const Text(
              'Minhas Obras',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...minhasObras.map(
              (obra) => Card(
                child: ListTile(
                  title: Text(
                    obra.titulo,
                  ),
                  subtitle: Text(
                    '${obra.visualizacoes} visualizações • '
                    '${obra.totalAvaliacoes} avaliações',
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        obra.avaliacao.toStringAsFixed(1),
                      ),
                    ],
                  ),
                ),
              ),
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
