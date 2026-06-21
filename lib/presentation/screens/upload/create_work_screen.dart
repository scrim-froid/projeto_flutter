import 'package:flutter/material.dart';

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

  final descricaoController =
      TextEditingController();

  String genero = 'Ação';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Obra'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            GestureDetector(
              onTap: () {},

              child: Container(
                height: 220,
                width: 160,

                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.image,
                      size: 60,
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Selecionar capa',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: tituloController,

              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField(
              value: genero,

              items: const [
                DropdownMenuItem(
                  value: 'Ação',
                  child: Text('Ação'),
                ),
                DropdownMenuItem(
                  value: 'Fantasia',
                  child: Text('Fantasia'),
                ),
                DropdownMenuItem(
                  value: 'Drama',
                  child: Text('Drama'),
                ),
                DropdownMenuItem(
                  value: 'Terror',
                  child: Text('Terror'),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  genero = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descricaoController,
              maxLines: 5,

              decoration: const InputDecoration(
                labelText: 'Sinopse',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/create-chapter',
                  );
                },

                child: const Text(
                  'Próximo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}