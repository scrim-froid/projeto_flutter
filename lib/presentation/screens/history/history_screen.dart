import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/leitura_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historico =
        context.watch<LeituraProvider>().historico;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico',
        ),
      ),
      body: historico.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma leitura registrada.',
              ),
            )
          : ListView.builder(
              itemCount:
                  historico.length,
              itemBuilder:
                  (context, index) {
                final leitura =
                    historico[index];

                return ListTile(
                  leading: const Icon(
                    Icons.history,
                  ),
                  title: Text(
                    leitura.obraTitulo,
                  ),
                  subtitle: Text(
                    '${leitura.capituloTitulo} • Página ${leitura.paginaAtual + 1}',
                  ),
                );
              },
            ),
    );
  }
}