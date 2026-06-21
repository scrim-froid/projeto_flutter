import 'package:flutter/material.dart';

class ContinueReadingCard
    extends StatelessWidget {

  const ContinueReadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          children: [

            Container(
              width: 70,
              height: 100,

              decoration: BoxDecoration(
                color: Colors.grey.shade700,

                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.menu_book,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Samurai do Sertão',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Página 12 de 40',
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: 0.3,
                    borderRadius:
                        BorderRadius.circular(20),
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