import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';

import '../history/history_screen.dart';
import '../profile/my_works_screen.dart';
import '../stats/stats_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      await context.read<UserProvider>().carregarUsuario(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;

    final userProvider = context.watch<UserProvider>();

    final usuario = userProvider.usuario;

    if (usuario == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isAuthor = usuario.isAuthor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              usuario.nome.isNotEmpty
                  ? usuario.nome
                  : authUser?.email ?? 'Usuário',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (usuario.bio.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Text(
                  usuario.bio,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isAuthor ? Colors.orange : Colors.blue,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isAuthor ? Icons.edit_note : Icons.menu_book,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    isAuthor ? 'Autor' : 'Leitor',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (!isAuthor)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    await context.read<UserProvider>().tornarAutor();

                    if (!mounted) return;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Agora você é um autor!',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                  label: const Text(
                    'Tornar-se Autor',
                  ),
                ),
              ),
            const SizedBox(height: 24),
            if (isAuthor) ...[
              ListTile(
                leading: const Icon(
                  Icons.library_books,
                ),
                title: const Text(
                  'Minhas Obras',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyWorksScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                ),
                title: const Text(
                  'Nova Obra',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/create-work',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.bar_chart,
                ),
                title: const Text(
                  'Estatísticas',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StatsScreen(),
                    ),
                  );
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(
                  Icons.bar_chart,
                ),
                title: const Text(
                  'Estatísticas',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StatsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.history,
                ),
                title: const Text(
                  'Histórico',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HistoryScreen(),
                    ),
                  );
                },
              ),
            ],
            const Divider(
              height: 32,
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'Configurações',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text(
                'Sair',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () async {
                final confirmar = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Sair',
                      ),
                      content: const Text(
                        'Deseja realmente encerrar sua sessão?',
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
                            'Sair',
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirmar == true) {
                  await context.read<AuthProvider>().logout();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
