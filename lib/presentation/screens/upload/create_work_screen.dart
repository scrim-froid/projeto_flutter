import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/obra_model.dart';
import '../../../providers/obra_provider.dart';
import '../../../services/storage_cloud_service.dart';

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

  bool carregando = false;

  Future<void> selecionarCapa() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem != null) {
      setState(() {
        capaSelecionada = File(imagem.path);
      });
    }
  }

  Future<void> publicarObra() async {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o título da obra.',
          ),
        ),
      );
      return;
    }

    if (autorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o autor.',
          ),
        ),
      );
      return;
    }

    if (capaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione uma capa.',
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        carregando = true;
      });

      final urlCapa = await StorageCloudService().uploadImagem(
        capaSelecionada!,
        'capas',
      );

      final usuario = context.read<UserProvider>().usuario;

      final novaObra = ObraModel(
        id: '',
        titulo: tituloController.text,
        autor: autorController.text,
        genero: generoController.text,
        sinopse: sinopseController.text,
        autorId: usuario!.uid,
        autorNome: usuario.nome.isNotEmpty ? usuario.nome : usuario.email,
        avaliacao: 0,
        visualizacoes: 0,
        capa: urlCapa,
        capitulos: [],
      );

      await context.read<ObraProvider>().adicionarObra(
            novaObra,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Obra publicada com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao publicar: $e',
          ),
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
  void dispose() {
    tituloController.dispose();
    autorController.dispose();
    generoController.dispose();
    sinopseController.dispose();

    super.dispose();
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
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: capaSelecionada != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        child: kIsWeb
                            ? Image.network(
                                capaSelecionada!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
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
                          Text(
                            'Selecionar capa',
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: carregando ? null : publicarObra,
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
