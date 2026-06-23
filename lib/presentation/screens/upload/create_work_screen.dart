import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/obra_model.dart';
import '../../../providers/obra_provider.dart';

class CreateWorkScreen extends StatefulWidget {
  const CreateWorkScreen({super.key});

  @override
  State<CreateWorkScreen> createState() => _CreateWorkScreenState();
}

class _CreateWorkScreenState extends State<CreateWorkScreen> {
  final tituloController = TextEditingController();

  final autorController = TextEditingController();

  final generoController = TextEditingController();

  final sinopseController = TextEditingController();

  File? capaSelecionada;

  Future<void> selecionarCapa() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem != null) {
      setState(() {
        capaSelecionada = File(
          imagem.path,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Obra',
        ),
      ),
      body: SingleChildScrollView(
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
              controller: autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: generoController,
              decoration: const InputDecoration(
                labelText: 'Gênero',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sinopseController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Sinopse',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: selecionarCapa,
              child: Container(
                height: 180,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: capaSelecionada != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          capaSelecionada!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text('Selecionar capa'),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final novaObra = ObraModel(
                    titulo: tituloController.text,
                    autor: autorController.text,
                    genero: generoController.text,
                    sinopse: sinopseController.text,
                    avaliacao: 0,
                    capa: capaSelecionada?.path ?? '',
                    capitulos: [],
                  );

                  context.read<ObraProvider>().adicionarObra(
                        novaObra,
                      );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Obra publicada!',
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
