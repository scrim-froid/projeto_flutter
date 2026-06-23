import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leitura_provider.dart';

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
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Continuar leitura será implementado em seguida.',
              ),
            ),
          );
        },
      ),
    );
  }
}