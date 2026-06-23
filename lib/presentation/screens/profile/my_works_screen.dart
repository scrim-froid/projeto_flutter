import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/screens/upload/edit_work_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';
import '../obra/obra_detail_screen.dart';
import '../upload/create_chapter_screen.dart';

class MyWorksScreen extends StatelessWidget {
  const MyWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ObraProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Obras'),
      ),
      body: provider.obras.isEmpty
          ? const Center(
              child: Text(
                'Você ainda não publicou nenhuma obra.',
              ),
            )
          : ListView.builder(
              itemCount: provider.obras.length,
              itemBuilder: (context, index) {
                final obra = provider.obras[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: Text(obra.titulo),
                    subtitle: Text(
                      '${obra.capitulos.length} capítulos',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ObraDetailScreen(
                            obra: obra,
                          ),
                        ),
                      );
                    },
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'capitulo') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateChapterScreen(
                                obra: obra,
                              ),
                            ),
                          );
                        }
                        if (value == 'editar') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditWorkScreen(
                                obra: obra,
                              ),
                            ),
                          );
                        }

                        if (value == 'excluir') {
                          final confirmar = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text(
                                'Excluir obra?',
                              ),
                              content: Text(
                                'Deseja excluir "${obra.titulo}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      false,
                                    );
                                  },
                                  child: const Text(
                                    'Cancelar',
                                  ),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      true,
                                    );
                                  },
                                  child: const Text(
                                    'Excluir',
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirmar == true) {
                            await context
                                .read<ObraProvider>()
                                .removerObra(obra);

                            if (context.mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${obra.titulo} removida',
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'capitulo',
                          child: Text(
                            'Novo Capítulo',
                          ),
                        ),
                        PopupMenuItem(
                          value: 'editar',
                          child: Text('Editar'),
                        ),
                        PopupMenuItem(
                          value: 'excluir',
                          child: Text(
                            'Excluir',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/create-work',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
