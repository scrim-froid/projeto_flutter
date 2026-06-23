import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/screens/obra/obra_detail_screen.dart';
import 'package:projeto_flutter/providers/obra_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/obra_card.dart';
import '../../widgets/featured_banner.dart';
import '../../widgets/continue_reading_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InkBR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar HQs e Mangás',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              const FeaturedBanner(),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '📖 Continuar Lendo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              const ContinueReadingCard(),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '📚 Em Destaque',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
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
              Consumer<ObraProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.obras.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final obra = provider.obras[index];

                      return ObraCard(
                        obra: obra,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ObraDetailScreen(
                                obra: obra,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
