import 'package:flutter/material.dart';

class CreateChapterScreen extends StatefulWidget {
  const CreateChapterScreen({super.key});

  @override
  State<CreateChapterScreen> createState() =>
      _CreateChapterScreenState();
}

class _CreateChapterScreenState
    extends State<CreateChapterScreen> {

  final tituloController =
      TextEditingController();

  final numeroController =
      TextEditingController();

  final paginas = <String>[
    'Página 1',
    'Página 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Capítulo'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: tituloController,

              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: numeroController,

              keyboardType:
                  TextInputType.number,

              decoration: const InputDecoration(
                labelText:
                    'Número do capítulo',
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Páginas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      paginas.add(
                        'Página ${paginas.length + 1}',
                      );
                    });
                  },

                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: paginas.length,

                itemBuilder:
                    (context, index) {
                  return Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.image),

                      title:
                          Text(paginas[index]),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Capítulo publicado com sucesso!',
                      ),
                    ),
                  );
                },

                child: const Text(
                  'Publicar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}