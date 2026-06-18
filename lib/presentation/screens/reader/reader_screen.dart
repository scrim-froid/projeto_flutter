import 'package:flutter/material.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Capítulo 1"),
      ),

      body: PageView(
        children: [

          Image.network(
            "https://picsum.photos/400/800",
            fit: BoxFit.contain,
          ),

          Image.network(
            "https://picsum.photos/401/800",
            fit: BoxFit.contain,
          ),

          Image.network(
            "https://picsum.photos/402/800",
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}