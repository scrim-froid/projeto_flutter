import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ObraCard extends StatelessWidget {
  final String titulo;
  final String autor;

  const ObraCard({
    super.key,
    required this.titulo,
    required this.autor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),

              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  autor,
                  style: const TextStyle(
                    color: AppColors.subtitle,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}