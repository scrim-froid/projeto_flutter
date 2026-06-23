import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/favoritos_provider.dart';
import '../../widgets/obra_card.dart';
import '../obra/obra_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritos =
        context.watch<FavoritosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),

      body: favoritos.favoritos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Nenhuma obra favoritada',
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding:
                  const EdgeInsets.all(16),

              itemCount:
                  favoritos.favoritos.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,

                childAspectRatio: 0.65,
              ),

              itemBuilder:
                  (context, index) {
                final obra =
                    favoritos.favoritos[index];

                return ObraCard(
                  obra: obra,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ObraDetailScreen(
                          obra: obra,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}