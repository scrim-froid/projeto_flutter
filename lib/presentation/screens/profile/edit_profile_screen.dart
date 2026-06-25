import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  late TextEditingController nomeController;
  late TextEditingController bioController;

  bool carregando = false;

  @override
  void initState() {
    super.initState();

    final usuario =
        context.read<UserProvider>().usuario;

    nomeController = TextEditingController(
      text: usuario?.nome ?? '',
    );

    bioController = TextEditingController(
      text: usuario?.bio ?? '',
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> salvar() async {
    try {
      setState(() {
        carregando = true;
      });

      await context
          .read<UserProvider>()
          .atualizarPerfil(
            nome: nomeController.text.trim(),
            bio: bioController.text.trim(),
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Perfil atualizado!',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Erro: $e',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    carregando ? null : salvar,
                child: carregando
                    ? const CircularProgressIndicator()
                    : const Text(
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