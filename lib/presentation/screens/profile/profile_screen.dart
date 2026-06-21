import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  bool isAuthor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
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

            const Text(
              'André Moraes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
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

            const SizedBox(height: 24),

            if (!isAuthor)
              SizedBox(
                width: double.infinity,

                child: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      isAuthor = true;
                    });

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

                  icon: const Icon(Icons.edit),

                  label: const Text(
                    'Tornar-se Autor',
                  ),
                ),
              ),

            const SizedBox(height: 24),

            if (isAuthor) ...[
              ListTile(
                leading:
                    const Icon(Icons.menu_book),

                title:
                    const Text('Minhas Obras'),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {},
              ),

              ListTile(
                leading:
                    const Icon(Icons.add),

                title:
                    const Text('Nova Obra'),

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
                leading:
                    const Icon(Icons.bar_chart),

                title:
                    const Text('Estatísticas'),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {},
              ),
            ] else ...[
              ListTile(
                leading:
                    const Icon(Icons.favorite),

                title:
                    const Text('Favoritos'),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {},
              ),

              ListTile(
                leading:
                    const Icon(Icons.history),

                title:
                    const Text('Histórico'),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {},
              ),
            ],

            const Divider(height: 32),

            ListTile(
              leading:
                  const Icon(Icons.settings),

              title:
                  const Text('Configurações'),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {},
            ),

            ListTile(
              leading:
                  const Icon(Icons.logout),

              title: const Text('Sair'),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}