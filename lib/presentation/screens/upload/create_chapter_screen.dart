import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_flutter/providers/obra_provider.dart';
import 'package:projeto_flutter/services/storage_cloud_service.dart';
import 'package:provider/provider.dart';

import '../../../data/models/capitulo_model.dart';
import '../../../data/models/obra_model.dart';

class CreateChapterScreen extends StatefulWidget {
  final ObraModel obra;

  const CreateChapterScreen({
    super.key,
    required this.obra,
  });

  @override
  State<CreateChapterScreen> createState() => _CreateChapterScreenState();
}

class _CreateChapterScreenState extends State<CreateChapterScreen> {
  bool carregando = false;

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

  Future publicarCapitulo() async {
    if (tituloController.text.trim().isEmpty) return;
    if (numeroController.text.trim().isEmpty) return;

    try {
      setState(() {
        carregando = true;
      });

      final storage = StorageCloudService();
      final paginasUrl = <String>[];

      for (final pagina in paginas) {
        final url = await storage.uploadImagem(
          pagina,
          'capitulos',
        );

        paginasUrl.add(url);
      }

      final numero = int.tryParse(numeroController.text);

      if (numero == null) return;

      final capituloRef = FirebaseFirestore.instance
          .collection('obras')
          .doc(widget.obra.id)
          .collection('capitulos')
          .doc(); // ID gerado

      final novoCapitulo = CapituloModel(
        id: capituloRef.id,
        numero: numero,
        titulo: tituloController.text,
        paginas: paginasUrl,
      );

      await capituloRef.set(novoCapitulo.toJson());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Capítulo publicado com sucesso!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao publicar capítulo: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
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
                labelText: 'Número do capítulo',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Páginas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
                      itemCount: paginas.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: kIsWeb
                                ? Image.network(
                                    paginas[index].path,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
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
                onPressed: carregando ? null : publicarCapitulo,
                child: carregando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
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
