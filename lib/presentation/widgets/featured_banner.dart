import 'package:flutter/material.dart';

class FeaturedBanner extends StatelessWidget {
  const FeaturedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Color(0xFFFF6B00),
            Color(0xFFFF8C42),
          ],
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Text(
              '🔥 Destaque da Semana',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Samurai do Sertão',
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Novo capítulo disponível',
            ),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/obra',
                );
              },

              child: const Text(
                'Ler Agora',
              ),
            ),
          ],
        ),
      ),
    );
  }
}