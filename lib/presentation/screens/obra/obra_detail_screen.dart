import 'package:flutter/material.dart';
import 'package:projeto_flutter/providers/favoritos_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/obra_model.dart';

class ObraDetailScreen extends StatelessWidget {

  final ObraModel obra;

  const ObraDetailScreen({
    super.key,
    required this.obra,
  });

  @override
  Widget build(BuildContext context) {
    final obra = ObraModel(
      titulo: "Samurai do Sertão",
      autor: "André Moraes",
      capa: "",
      genero: "Ação",
      avaliacao: 4.8,
      sinopse:
          "Em um Brasil alternativo, um samurai percorre o sertão enfrentando criaturas e guerreiros lendários.",
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey.shade800,
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 100,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obra.titulo,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    obra.autor,
                    style: TextStyle(
                      color: AppColors.subtitle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          obra.genero,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(obra.avaliacao.toString()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Sinopse",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    obra.sinopse,
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<FavoritosProvider>(
                          builder: (
                            context,
                            favoritos,
                            child,
                          ) {
                            const titulo = "Samurai do Sertão";

                            final isFavorito = favoritos.isFavorito(
                              obra,
                            );

                            return FilledButton.icon(
                              onPressed: () {
                                favoritos.toggleFavorito(
                                  obra,
                                );

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isFavorito
                                          ? "Removido dos favoritos"
                                          : "Adicionado aos favoritos",
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                isFavorito
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              label: Text(
                                isFavorito ? "Favoritado" : "Favoritar",
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/reader',
                            );
                          },
                          icon: const Icon(
                            Icons.menu_book,
                          ),
                          label: const Text("Ler"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Capítulos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    5,
                    (index) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            "${index + 1}",
                          ),
                        ),
                        title: Text(
                          "Capítulo ${index + 1}",
                        ),
                        subtitle: const Text(
                          "20 páginas",
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/reader',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
