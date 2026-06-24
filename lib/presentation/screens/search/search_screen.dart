import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  String busca = '';

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<ObraProvider>();

    final resultados =
        provider.buscarObras(busca);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar Obras',
        ),
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(16),

            child: TextField(
              decoration:
                  const InputDecoration(
                hintText:
                    'Título, autor ou gênero',
                prefixIcon:
                    Icon(Icons.search),
              ),

              onChanged: (value) {
                setState(() {
                  busca = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  resultados.length,

              itemBuilder:
                  (context, index) {

                final obra =
                    resultados[index];

                return ListTile(
                  title: Text(
                    obra.titulo,
                  ),

                  subtitle: Text(
                    obra.autor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}