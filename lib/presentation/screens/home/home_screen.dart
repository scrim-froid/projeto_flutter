import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';
import '../../widgets/obra_card.dart';
import '../obra/obra_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obras = context.watch<ObraProvider>().obras;

    final populares = [...obras];
    populares.sort(
      (a, b) => b.visualizacoes.compareTo(a.visualizacoes),
    );

    final avaliadas = [...obras];
    avaliadas.sort(
      (a, b) => b.avaliacao.compareTo(a.avaliacao),
    );

    final recentes = obras.reversed.toList();

    Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem-vindo ao InkBR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Leia, publique e compartilhe histórias.',
          ),
        ],
      ),
    );

    for (final obra in obras) {
  print('Obra: ${obra.titulo}');
}

    return Scaffold(
      appBar: AppBar(
        title: const Text('InkBR'),
      ),
      body: ListView(
        children: [
          _secao(
            context,
            '🔥 Mais Populares',
            populares.take(10).toList(),
          ),
          _secao(
            context,
            '⭐ Melhor Avaliadas',
            avaliadas.take(10).toList(),
          ),
          _secao(
            context,
            '🆕 Adicionadas Recentemente',
            recentes.take(10).toList(),
          ),
        ],
      ),
    );
  }

  Widget _secao(
    BuildContext context,
    String titulo,
    List obras,
  ) {
    if (obras.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            titulo,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: obras.length,
            itemBuilder: (context, index) {
              final obra = obras[index];

              return SizedBox(
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    bottom: 12,
                  ),
                  child: ObraCard(
                    obra: obra,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ObraDetailScreen(
                            obra: obra,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
