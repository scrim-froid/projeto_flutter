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
              child: Container(
                color: Colors.grey.shade800,
                child: const Center(
                  child: Icon(
                    Icons.menu_book,
                    size: 60,
                  ),
                ),
              ),
            ),
            Padding(
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
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Text(
                        '⭐ ${obra.avaliacao.toStringAsFixed(1)}',
                      ),
                      Text(
                        '❤ ${obra.favoritos}',
                      ),
                      Text(
                        '👁 ${obra.visualizacoes}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
