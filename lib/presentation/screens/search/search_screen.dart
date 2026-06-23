import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';
import '../obra/obra_detail_screen.dart';
import '../../widgets/obra_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  String pesquisa = '';

  @override
  Widget build(BuildContext context) {

    final obras =
        context.watch<ObraProvider>().obras;

    final resultados = obras.where((obra) {

      return obra.titulo
              .toLowerCase()
              .contains(
                pesquisa.toLowerCase(),
              ) ||
          obra.genero
              .toLowerCase()
              .contains(
                pesquisa.toLowerCase(),
              );

    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              decoration:
                  const InputDecoration(
                hintText:
                    'Buscar obra...',
                prefixIcon:
                    Icon(Icons.search),
              ),

              onChanged: (value) {
                setState(() {
                  pesquisa = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: resultados.length,

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
                      resultados[index];

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
            ),
          ],
        ),
      ),
    );
  }
}