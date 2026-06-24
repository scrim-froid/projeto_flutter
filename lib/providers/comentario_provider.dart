import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/comentario_model.dart';

class ComentarioProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ComentarioModel>> comentariosDaObra(
    String obraId,
  ) {
    return _db
        .collection('obras')
        .doc(obraId)
        .collection('comentarios')
        .orderBy(
          'data',
          descending: true,
        )
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return ComentarioModel.fromJson(
              doc.data(),
              doc.id,
            );
          },
        ).toList();
      },
    );
  }

  Future<void> adicionarComentario({
    required String obraId,
    required ComentarioModel comentario,
  }) async {
    await _db.collection('obras').doc(obraId).collection('comentarios').add(
          comentario.toJson(),
        );
  }

  Future<void> atualizarAvaliacaoObra(
    String obraId,
  ) async {
    final comentarios = await _db
        .collection('obras')
        .doc(obraId)
        .collection('comentarios')
        .get();

    if (comentarios.docs.isEmpty) {
      return;
    }

    double soma = 0;

    for (final doc in comentarios.docs) {
      soma += (doc['nota'] as num).toDouble();
    }

    final media = soma / comentarios.docs.length;

    await _db.collection('obras').doc(obraId).update({
      'avaliacao': media,
      'totalAvaliacoes': comentarios.docs.length,
    });
  }
  
}
