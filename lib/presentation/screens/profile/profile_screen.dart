import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 50),
            ),

            SizedBox(height: 16),

            Text(
              "André",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text("Leitor"),

            SizedBox(height: 30),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Configurações"),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sair"),
            ),
          ],
        ),
      ),
    );
  }
}