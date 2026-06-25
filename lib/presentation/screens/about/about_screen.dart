import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Projeto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Center(
              child: Icon(
                Icons.menu_book,
                size: 80,
                color: Colors.orange,
              ),
            ),

            SizedBox(height: 16),

            Center(
              child: Text(
                'InkBR',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8),

            Center(
              child: Text(
                'Plataforma de leitura e publicação de HQs, mangás e webtoons.',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 32),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Desenvolvedor'),
              subtitle: Text('André Moraes'),
            ),

            ListTile(
              leading: Icon(Icons.school),
              title: Text('Projeto Acadêmico'),
              subtitle: Text('Curso de Desenvolvimento de Sistemas'),
            ),

            ListTile(
              leading: Icon(Icons.code),
              title: Text('Tecnologias'),
              subtitle: Text(
                'Flutter, Firebase Auth, Firestore, Provider',
              ),
            ),

            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Versão'),
              subtitle: Text('1.0.0'),
            ),

            SizedBox(height: 24),

            Text(
              'Objetivo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'O InkBR foi desenvolvido para permitir que autores publiquem suas obras e leitores acompanhem histórias de forma simples, organizada e acessível.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}