import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter/providers/obra_provider.dart';
import '../../../data/models/obra_model.dart';

class EditWorkScreen extends StatefulWidget {
  final ObraModel obra;

  const EditWorkScreen({
    super.key,
    required this.obra,
  });

  @override
  State<EditWorkScreen> createState() => _EditWorkScreenState();
}

class _EditWorkScreenState extends State<EditWorkScreen> {
  late TextEditingController tituloController;
  late TextEditingController autorController;
  late TextEditingController generoController;
  late TextEditingController sinopseController;

  @override
  void initState() {
    super.initState();

    tituloController = TextEditingController(
      text: widget.obra.titulo,
    );

    autorController = TextEditingController(
      text: widget.obra.autor,
    );

    generoController = TextEditingController(
      text: widget.obra.genero,
    );

    sinopseController = TextEditingController(
      text: widget.obra.sinopse,
    );
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
        title: const Text('Editar Obra'),
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  widget.obra.titulo = tituloController.text;

                  widget.obra.autor = autorController.text;

                  widget.obra.genero = generoController.text;

                  widget.obra.sinopse = sinopseController.text;

                  await context.read<ObraProvider>().atualizarObra();

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Salvar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
