import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/capitulo_model.dart';
import '../../../data/models/obra_model.dart';
import '../../../providers/obra_provider.dart';

class CreateChapterScreen extends StatefulWidget {
  final ObraModel obra;

  const CreateChapterScreen({
    super.key,
    required this.obra,
  });

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

  final List<String> paginas = [];

  @override
  void dispose() {
    tituloController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Capítulo',
        ),
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

                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),

            Expanded(
              child: paginas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma página adicionada',
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          paginas.length,

                      itemBuilder:
                          (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.image,
                            ),

                            title: Text(
                              paginas[index],
                            ),

                            trailing:
                                IconButton(
                              icon: const Icon(
                                Icons.delete,
                              ),

                              onPressed: () {
                                setState(() {
                                  paginas.removeAt(
                                    index,
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: () {

                  if (tituloController
                      .text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Informe o título do capítulo.',
                        ),
                      ),
                    );
                    return;
                  }

                  if (numeroController
                      .text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Informe o número do capítulo.',
                        ),
                      ),
                    );
                    return;
                  }

                  if (paginas.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Adicione pelo menos uma página.',
                        ),
                      ),
                    );
                    return;
                  }

                  final novoCapitulo =
                      CapituloModel(
                    numero: int.parse(
                      numeroController.text,
                    ),

                    titulo:
                        tituloController.text,

                    paginas: List.generate(
                      paginas.length,
                      (index) =>
                          'assets/pages/default.png',
                    ),
                  );

                  context
                      .read<ObraProvider>()
                      .adicionarCapitulo(
                        widget.obra,
                        novoCapitulo,
                      );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Capítulo publicado com sucesso!',
                      ),
                    ),
                  );

                  Navigator.pop(
                    context,
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