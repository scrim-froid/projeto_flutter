import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/favoritos_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favoritos.favoritos.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma obra favoritada',
              ),
            )
          : ListView.builder(
              itemCount: favoritos.favoritos.length,
              itemBuilder: (context, index) {
                final obra = favoritos.favoritos[index];

                return ListTile(
                  leading: const Icon(
                    Icons.favorite,
                  ),
                  title: Text(
                    obra.titulo,
                  ),
                  subtitle: Text(
                    obra.autor,
                  ),
                );
              },
            ),
    );
  }
}
