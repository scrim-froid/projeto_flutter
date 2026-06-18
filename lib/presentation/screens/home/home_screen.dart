import 'package:flutter/material.dart';

import '../../widgets/obra_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obras = [
      {
        'titulo': 'Samurai do Sertão',
        'autor': 'André',
      },
      {
        'titulo': 'Cyber Brasil',
        'autor': 'Lucas',
      },
      {
        'titulo': 'Nanquim Sombrio',
        'autor': 'Maria',
      },
      {
        'titulo': 'A Lenda de Aruã',
        'autor': 'João',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InkBR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText:
                    'Pesquisar HQs e Mangás',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Chip(label: Text('Ação')),
                  SizedBox(width: 8),
                  Chip(label: Text('Fantasia')),
                  SizedBox(width: 8),
                  Chip(label: Text('Drama')),
                  SizedBox(width: 8),
                  Chip(label: Text('Terror')),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                itemCount: obras.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 12,

                  mainAxisSpacing: 12,

                  childAspectRatio: 0.65,
                ),

                itemBuilder: (context, index) {
                  return ObraCard(
                    titulo:
                        obras[index]['titulo']!,
                    autor:
                        obras[index]['autor']!,
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