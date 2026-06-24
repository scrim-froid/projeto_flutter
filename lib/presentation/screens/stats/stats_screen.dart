import 'package:flutter/material.dart';
import 'package:projeto_flutter/providers/obra_provider.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final obras =
        context.watch<ObraProvider>().obras;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Estatísticas',
        ),
      ),

      body: ListView.builder(
        itemCount: obras.length,

        itemBuilder: (context, index) {

          final obra = obras[index];

          return Card(
            margin: const EdgeInsets.all(12),

            child: ListTile(
              title: Text(
                obra.titulo,
              ),

              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    '👁 ${obra.visualizacoes} visualizações',
                  ),

                  Text(
                    '❤️ ${obra.favoritos} favoritos',
                  ),

                  Text(
                    '📖 ${obra.capitulos.length} capítulos',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}