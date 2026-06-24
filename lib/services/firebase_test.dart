import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest {
  static Future<void> testar() async {
    await FirebaseFirestore.instance
        .collection('teste')
        .add({
      'mensagem': 'InkBR conectado!',
      'data': DateTime.now().toString(),
    });
  }
}