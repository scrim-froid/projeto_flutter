import 'package:flutter/material.dart';

class ObraDetailScreen extends StatelessWidget {
  const ObraDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Container(
              height: 300,
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.image, size: 80),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Samurai do Sertão",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Uma aventura épica no interior do Brasil.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Capítulos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ListTile(
                    title: const Text(
                      "Capítulo 1",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/reader',
                      );
                    },
                  ),

                  ListTile(
                    title: const Text(
                      "Capítulo 2",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}