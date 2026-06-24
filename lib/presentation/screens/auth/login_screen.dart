import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/models/user_model.dart';
import 'package:projeto_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../navigation/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final senhaController = TextEditingController();

  bool carregando = false;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      setState(() {
        carregando = true;
      });

      await context.read<AuthProvider>().login(
            emailController.text.trim(),
            senhaController.text.trim(),
          );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao entrar: $e',
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

  Future<void> cadastrar() async {
    try {
      setState(() {
        carregando = true;
      });

      final credential = await context.read<AuthProvider>().cadastrar(
            emailController.text.trim(),
            senhaController.text.trim(),
          );

      await context.read<UserProvider>().salvarUsuario(
            UserModel(
              uid: credential.user!.uid,
              email: credential.user!.email ?? '',
              nome: '',
              bio: '',
              isAuthor: false,
            ),
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Conta criada com sucesso!',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao cadastrar: $e',
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
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.menu_book,
                  size: 90,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                const Text(
                  "InkBR",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: carregando ? null : login,
                    child: carregando
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Entrar",
                          ),
                  ),
                ),
                TextButton(
                  onPressed: carregando ? null : cadastrar,
                  child: const Text(
                    "Criar Conta",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
