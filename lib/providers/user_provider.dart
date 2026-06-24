import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  UserModel? usuario;

  Future<void> carregarUsuario(
    String uid,
  ) async {
    final doc = await _db.collection('usuarios').doc(uid).get();

    if (!doc.exists) {
      usuario = null;
      notifyListeners();
      return;
    }

    usuario = UserModel.fromJson(
      doc.data()!,
    );

    notifyListeners();
  }

  Future<void> salvarUsuario(
    UserModel user,
  ) async {
    await _db.collection('usuarios').doc(user.uid).set(user.toJson());

    usuario = user;

    notifyListeners();
  }

  Future<void> tornarAutor() async {
    if (usuario == null) return;

    usuario = usuario!.copyWith(
      isAuthor: true,
    );

    await salvarUsuario(usuario!);
  }

  Future<UserModel?> buscarUsuario(
    String uid,
  ) async {
    final doc =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

    if (!doc.exists) return null;

    return UserModel.fromJson(
      doc.data()!,
    );
  }
}
