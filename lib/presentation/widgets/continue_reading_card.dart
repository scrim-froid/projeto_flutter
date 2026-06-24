import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leitura_provider.dart';
import '../../providers/obra_provider.dart';
import '../screens/reader/reader_screen.dart';

class ContinueReadingCard extends StatelessWidget {
  const ContinueReadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final leitura =
        context.watch<LeituraProvider>().leituraAtual;

    if (leitura == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Nenhuma leitura iniciada.',
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.menu_book,
        ),
        title: Text(
          leitura.obraTitulo,
        ),
        subtitle: Text(
          '${leitura.capituloTitulo} • Página ${leitura.paginaAtual + 1}/${leitura.totalPaginas}',
        ),
        trailing: const Icon(
          Icons.play_arrow,
        ),
        onTap: () {
          final obras =
              context.read<ObraProvider>().obras;

          if (leitura.obraIndex >= obras.length) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Obra não encontrada.',
                ),
              ),
            );
            return;
          }

          final obra =
              obras[leitura.obraIndex];

          if (leitura.capituloIndex >=
              obra.capitulos.length) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Capítulo não encontrado.',
                ),
              ),
            );
            return;
          }

          final capitulo =
              obra.capitulos[
                  leitura.capituloIndex];

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReaderScreen(
                obra: obra,
                capitulo: capitulo,
                obraIndex: leitura.obraIndex,
                capituloIndex:
                    leitura.capituloIndex,
                paginaInicial:
                    leitura.paginaAtual,
              ),
            ),
          );
        },
      ),
    );
  }
}