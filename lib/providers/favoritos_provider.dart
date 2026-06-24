import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/obra_model.dart';

class FavoritosProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<String> _favoritos = [];

  List<String> get favoritos => _favoritos;

  bool isFavorito(String obraId) {
    return _favoritos.contains(
      obraId,
    );
  }

  Future<void> carregarFavoritos(
    String uid,
  ) async {
    final snapshot =
        await _db.collection('usuarios').doc(uid).collection('favoritos').get();

    _favoritos.clear();

    _favoritos.addAll(
      snapshot.docs.map(
        (doc) => doc.id,
      ),
    );

    notifyListeners();
  }

  Future<void> toggleFavorito({
    required String uid,
    required ObraModel obra,
  }) async {
    final docRef = _db
        .collection('usuarios')
        .doc(uid)
        .collection('favoritos')
        .doc(obra.id);

    if (_favoritos.contains(
      obra.id,
    )) {
      await docRef.delete();

      _favoritos.remove(
        obra.id,
      );

      if (obra.favoritos > 0) {
        obra.favoritos--;
      }
    } else {
      await docRef.set({
        'obraId': obra.id,
        'titulo': obra.titulo,
        'data': Timestamp.now(),
      });

      _favoritos.add(
        obra.id!,
      );

      obra.favoritos++;
    }

    notifyListeners();
  }
}
