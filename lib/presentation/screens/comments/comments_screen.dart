import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/comentario_model.dart';
import '../../../data/models/obra_model.dart';
import '../../../providers/comentario_provider.dart';

class CommentsScreen extends StatefulWidget {
  final ObraModel obra;

  const CommentsScreen({
    super.key,
    required this.obra,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final ComentarioProvider _provider = ComentarioProvider();

  final TextEditingController comentarioController = TextEditingController();

  int nota = 5;

  Future<void> enviarComentario() async {
    final texto = comentarioController.text.trim();

    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um comentário',
          ),
        ),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final comentario = ComentarioModel(
      id: '',
      uid: user.uid,
      nome: user.displayName ?? user.email ?? 'Usuário',
      texto: texto,
      nota: nota,
      data: DateTime.now(),
    );

    await _provider.adicionarComentario(
      obraId: widget.obra.id!,
      comentario: comentario,
    );

    comentarioController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Comentário enviado!',
        ),
      ),
    );
  }

  @override
  void dispose() {
    comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comentários - ${widget.obra.titulo}',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: comentarioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Escreva seu comentário...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            nota = index + 1;
                          });
                        },
                        icon: Icon(
                          index < nota ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) return;

                      final usuario = context.read<UserProvider>().usuario;

                      final comentario = ComentarioModel(
                        id: '',
                        uid: user.uid,
                        nome: (usuario?.nome.trim().isNotEmpty ?? false)
                            ? usuario!.nome
                            : (user.email?.split('@').first ?? 'Usuário'),
                        texto: comentarioController.text,
                        nota: nota,
                        data: DateTime.now(),
                      );

                      await _provider.adicionarComentario(
                        obraId: widget.obra.id!,
                        comentario: comentario,
                      );

                      await _provider.atualizarAvaliacaoObra(
                        widget.obra.id!,
                      );

                      comentarioController.clear();
                    },
                    child: const Text(
                      'Enviar',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List<ComentarioModel>>(
              stream: _provider.comentariosDaObra(
                widget.obra.id!,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final comentarios = snapshot.data!;

                return ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    final comentario = comentarios[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          comentario.nome,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                comentario.nota,
                                (_) => const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Text(
                              comentario.texto,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
