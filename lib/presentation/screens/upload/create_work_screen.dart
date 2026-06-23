import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/obra_model.dart';
import '../../../providers/obra_provider.dart';

class CreateWorkScreen extends StatefulWidget {
  const CreateWorkScreen({super.key});

  @override
  State<CreateWorkScreen> createState() =>
      _CreateWorkScreenState();
}

class _CreateWorkScreenState
    extends State<CreateWorkScreen> {

  final tituloController =
      TextEditingController();

  final autorController =
      TextEditingController();

  final generoController =
      TextEditingController();

  final sinopseController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Obra',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  tituloController,

              decoration:
                  const InputDecoration(
                labelText: 'Título',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  autorController,

              decoration:
                  const InputDecoration(
                labelText: 'Autor',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  generoController,

              decoration:
                  const InputDecoration(
                labelText: 'Gênero',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  sinopseController,

              maxLines: 4,

              decoration:
                  const InputDecoration(
                labelText: 'Sinopse',
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: () {

                  final novaObra =
                      ObraModel(
                    titulo:
                        tituloController.text,

                    autor:
                        autorController.text,

                    genero:
                        generoController.text,

                    sinopse:
                        sinopseController.text,

                    avaliacao: 0,

                    capa:
                        'assets/capas/default.png',

                    capitulos: [],
                  );

                  context
                      .read<ObraProvider>()
                      .adicionarObra(
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