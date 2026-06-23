import 'dart:io';

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
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: _buildCapa(),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obra.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    obra.autor,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        obra.avaliacao.toString(),
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

  Widget _buildCapa() {
    // imagem selecionada pelo usuário
    if (obra.capa.isNotEmpty && !obra.capa.startsWith('assets/')) {
      return Image.file(
        File(obra.capa),
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return _imagemPadrao();
        },
      );
    }

    // imagem dos assets
    if (obra.capa.isNotEmpty) {
      return Image.asset(
        obra.capa,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return _imagemPadrao();
        },
      );
    }

    return _imagemPadrao();
  }

  Widget _imagemPadrao() {
    return Container(
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(
          Icons.auto_stories,
          size: 60,
        ),
      ),
    );
  }
}
