import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/capitulo_model.dart';
import '../../../data/models/obra_model.dart';

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
  final tituloController = TextEditingController();

  final numeroController = TextEditingController();

  final List<File> paginas = [];

  Future<void> selecionarPagina() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem != null) {
      setState(() {
        paginas.add(
          File(imagem.path),
        );
      });
    }
  }

  @override
  void dispose() {
    tituloController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  void publicarCapitulo() {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o título do capítulo.',
          ),
        ),
      );
      return;
    }

    if (numeroController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o número do capítulo.',
          ),
        ),
      );
      return;
    }

    if (paginas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Adicione pelo menos uma página.',
          ),
        ),
      );
      return;
    }

    final novoCapitulo = CapituloModel(
      numero: int.parse(
        numeroController.text,
      ),
      titulo: tituloController.text,
      paginas: paginas
          .map((pagina) => pagina.path)
          .toList(),
    );

    widget.obra.capitulos.add(
      novoCapitulo,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Capítulo publicado com sucesso!',
        ),
      ),
    );

    Navigator.pop(context);
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
              keyboardType: TextInputType.number,
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
                  onPressed: selecionarPagina,
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
                            leading: Image.file(
                              paginas[index],
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              'Página ${index + 1}',
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    publicarCapitulo,
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