import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_flutter/data/models/capitulo_model.dart';

import '../data/models/obra_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> adicionarObra(
    ObraModel obra,
  ) async {
    final doc = await _db.collection('obras').add(obra.toJson());

    obra.id = doc.id;
  }

  Future<List<ObraModel>> carregarObras() async {
    final snapshot = await _db.collection('obras').get();

    return snapshot.docs.map((doc) {
      final obra = ObraModel.fromJson(doc.data());

      obra.id = doc.id;

      return obra;
    }).toList();
  }

  Future<void> adicionarCapitulo(
    String obraId,
    CapituloModel capitulo,
  ) async {
    await _db
        .collection('obras')
        .doc(obraId)
        .collection('capitulos')
        .add(capitulo.toJson());
  }

  Future<List<CapituloModel>> carregarCapitulos(
    String obraId,
  ) async {
    final snapshot = await _db
        .collection('obras')
        .doc(obraId)
        .collection('capitulos')
        .orderBy('numero')
        .get();

    return snapshot.docs.map((doc) {
      return CapituloModel.fromJson(
        doc.data(),
      );
    }).toList();
  }
}
