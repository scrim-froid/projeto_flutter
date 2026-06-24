import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';
import '../obra/obra_detail_screen.dart';

class AuthorProfileScreen extends StatelessWidget {
  final String autorId;

  const AuthorProfileScreen({
    super.key,
    required this.autorId,
  });

  @override
  Widget build(BuildContext context) {
    final obraProvider =
        context.watch<ObraProvider>();

    final obras =
        obraProvider.obrasDoAutor(
      autorId,
    );

    final nomeAutor = obras.isNotEmpty
        ? obras.first.autorNome
        : 'Autor';

    final totalViews = obras.fold(
      0,
      (total, obra) =>
          total + obra.visualizacoes,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Autor',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              nomeAutor,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Text('Autor'),

            const SizedBox(height: 8),

            Text(
              '${obras.length} obras publicadas',
            ),

            Text(
              '$totalViews visualizações',
            ),

            const SizedBox(height: 24),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Obras Publicadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: obras.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma obra encontrada.',
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          obras.length,
                      itemBuilder:
                          (
                            context,
                            index,
                          ) {
                        final obra =
                            obras[index];

                        return Card(
                          child: ListTile(
                            leading:
                                const Icon(
                              Icons
                                  .menu_book,
                            ),
                            title: Text(
                              obra.titulo,
                            ),
                            subtitle:
                                Text(
                              obra.genero,
                            ),
                            trailing:
                                const Icon(
                              Icons
                                  .arrow_forward_ios,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          ObraDetailScreen(
                                    obra:
                                        obra,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}