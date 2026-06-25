import 'package:flutter/material.dart';

import '../../data/models/obra_model.dart';

class ObraCard extends StatelessWidget {
  final ObraModel obra;
  final VoidCallback onTap;

  const ObraCard({
    super.key,
    required this.obra,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: _buildCapa(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obra.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      obra.genero,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          obra.avaliacao.toStringAsFixed(1),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.favorite,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          obra.favoritos.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          obra.visualizacoes.toString(),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${obra.totalAvaliacoes})',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapa() {
    if (obra.capa.isNotEmpty && obra.capa.startsWith('http')) {
      return Image.network(
        obra.capa,
        fit: BoxFit.cover,
      );
    }

    return Container(
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(
          Icons.menu_book,
          size: 60,
        ),
      ),
    );
  }
}
