import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageCloudService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImagem(
    File arquivo,
    String pasta,
  ) async {
    final nomeArquivo = DateTime.now().millisecondsSinceEpoch.toString();

    final ref = _storage.ref().child(pasta).child(nomeArquivo);

    await ref.putFile(arquivo);

    return await ref.getDownloadURL();
  }
}
