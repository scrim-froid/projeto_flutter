import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:provider/provider.dart';

import '../../../data/models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';

import '../history/history_screen.dart';
import '../profile/my_works_screen.dart';
import '../stats/stats_screen.dart';
import '../profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      final authUser =
          FirebaseAuth.instance.currentUser;

      if (authUser == null) return;

      final userProvider =
          context.read<UserProvider>();

      await userProvider.carregarUsuario(
        authUser.uid,
      );

      if (userProvider.usuario == null) {
        await userProvider.salvarUsuario(
          UserModel(
            uid: authUser.uid,
            email: authUser.email ?? '',
            nome: '',
            bio: '',
            isAuthor: false,
          ),
        );

        await userProvider.carregarUsuario(
          authUser.uid,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authUser =
        FirebaseAuth.instance.currentUser;

    final usuario =
        context.watch<UserProvider>().usuario;

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perfil',
          ),
        ),
        body: const Center(
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
              radius: 55,
              child: Icon(
                Icons.person,
                size: 55,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              usuario.nome.isEmpty
                  ? authUser?.email ?? 'Usuário'
                  : usuario.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              usuario.bio.isEmpty
                  ? 'Nenhuma bio cadastrada'
                  : usuario.bio,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isAuthor
                    ? Colors.orange
                    : Colors.blue,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isAuthor
                        ? Icons.edit_note
                        : Icons.menu_book,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isAuthor
                        ? 'Autor'
                        : 'Leitor',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EditProfileScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
              label: const Text(
                'Editar Perfil',
              ),
            ),

            const SizedBox(height: 24),

            if (!isAuthor)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    await context
                        .read<UserProvider>()
                        .tornarAutor();

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
                    Icons.auto_stories,
                  ),
                  label: const Text(
                    'Tornar-se Autor',
                  ),
                ),
              ),

            if (isAuthor) ...[
              const Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  'Painel do Autor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

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
                      builder: (_) =>
                          const MyWorksScreen(),
                    ),
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
                      builder: (_) =>
                          const StatsScreen(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.add_circle_outline,
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
            ],

            const Divider(
              height: 32,
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
                    builder: (_) =>
                        const HistoryScreen(),
                  ),
                );
              },
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
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/about',
                );
              },
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
  debugPrint('BOTAO SAIR CLICADO');

  final confirmar = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sair'),
        content: const Text(
          'Deseja realmente encerrar sua sessão?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint('CANCELAR');
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              debugPrint('CONFIRMOU');
              Navigator.pop(context, true);
            },
            child: const Text('Sair'),
          ),
        ],
      );
    },
  );

  debugPrint('RESULTADO: $confirmar');

  if (confirmar == true) {
    debugPrint('CHAMANDO LOGOUT');

    await context.read<AuthProvider>().logout();

    debugPrint('LOGOUT FINALIZADO');
  }
} ),
          ],
        ),
      ),
    );
  }
}