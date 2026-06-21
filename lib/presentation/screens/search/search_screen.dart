import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/mock/mock_obras.dart';
import 'package:projeto_flutter/data/models/obra_model.dart';
import 'package:projeto_flutter/presentation/screens/obra/obra_detail_screen.dart';

import '../../widgets/obra_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  late List<ObraModel> resultados;

  @override
  void initState() {
    super.initState();
    resultados = mockObras;
  }

  void pesquisar(String texto) {
    setState(() {
      resultados = mockObras.where((obra) {
        return obra.titulo.toLowerCase().contains(texto.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: pesquisar,
              decoration: const InputDecoration(
                hintText: 'Pesquisar HQs e Mangás',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Resultados (${resultados.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: resultados.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final obra = resultados[index];

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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
