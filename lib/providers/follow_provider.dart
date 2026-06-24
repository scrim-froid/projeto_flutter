import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowProvider extends ChangeNotifier {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  Future<void> seguirAutor({
    required String uid,
    required String autorId,
  }) async {
    await _db
        .collection('usuarios')
        .doc(uid)
        .collection('seguindo')
        .doc(autorId)
        .set({});

    await _db
        .collection('usuarios')
        .doc(autorId)
        .collection('seguidores')
        .doc(uid)
        .set({});
  }
}