import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/capitulo_model.dart';

class CapituloService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<CapituloModel> buscarCapitulo({
    required String obraId,
    required String capituloId,
  }) async {
    final doc = await _db
        .collection('obras')
        .doc(obraId)
        .collection('capitulos')
        .doc(capituloId)
        .get();

    if (!doc.exists) {
      throw Exception('Capítulo não encontrado');
    }

    return CapituloModel.fromJson(
      doc.data()!,
      id: doc.id,
    );
  }
}