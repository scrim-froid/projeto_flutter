import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/capitulo_model.dart';
import '../data/models/obra_model.dart';

class ObraProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<ObraModel> _obras = [];

  List<ObraModel> get obras => _obras;

  ObraProvider() {
    observarObras();
  }

  void observarObras() {
    _db.collection('obras').snapshots().listen((snapshot) {
      print('===== SNAPSHOT =====');

      for (final doc in snapshot.docs) {
        print(doc.id);
        print(doc.data());
      }
      _obras.clear();

      _obras.addAll(
        snapshot.docs.map((doc) {
          final obra = ObraModel.fromJson(doc.data());

          obra.id = doc.id;

          return obra;
        }),
      );

      notifyListeners();
    });
  }

  Future<void> adicionarObra(
    ObraModel obra,
  ) async {
    final doc = await _db.collection('obras').add(obra.toJson());

    obra.id = doc.id;

    _obras.add(obra);

    print('ID gerado: ${doc.id}');

    notifyListeners();
  }

  Future<void> atualizarObra(
    ObraModel obra,
  ) async {
    await _db.collection('obras').doc(obra.id).update(
          obra.toJson(),
        );

    notifyListeners();
  }

  Future<void> removerObra(
    ObraModel obra,
  ) async {
    await _db.collection('obras').doc(obra.id).delete();

    _obras.removeWhere(
      (item) => item.id == obra.id,
    );

    notifyListeners();
  }

  Future adicionarCapitulo(
    ObraModel obra,
    CapituloModel capitulo,
  ) async {
    obra.capitulos.add(capitulo);

    await atualizarObra(obra);
  }

  List<ObraModel> buscarObras(
    String texto,
  ) {
    if (texto.isEmpty) {
      return obras;
    }

    return obras.where(
      (obra) {
        return obra.titulo.toLowerCase().contains(
                  texto.toLowerCase(),
                ) ||
            obra.autor.toLowerCase().contains(
                  texto.toLowerCase(),
                ) ||
            obra.genero.toLowerCase().contains(
                  texto.toLowerCase(),
                );
      },
    ).toList();
  }

  List<ObraModel> minhasObras(
    String autorId,
  ) {
    return _obras
        .where(
          (obra) => obra.autorId == autorId,
        )
        .toList();
  }

  List<ObraModel> obrasDoAutor(
    String autorId,
  ) {
    return _obras
        .where(
          (obra) => obra.autorId == autorId,
        )
        .toList();
  }

  List<ObraModel> get melhoresObras {
    final lista = List<ObraModel>.from(
      _obras,
    );

    lista.sort(
      (a, b) => b.avaliacao.compareTo(
        a.avaliacao,
      ),
    );

    return lista.take(10).toList();
  }

  Future<void> incrementarVisualizacao(
    ObraModel obra,
  ) async {
    await _db.collection('obras').doc(obra.id).update({
      'visualizacoes': FieldValue.increment(1),
    });
  }

  int get totalVisualizacoes {
    return _obras.fold(
      0,
      (total, obra) => total + obra.visualizacoes,
    );
  }

  int get totalFavoritos {
    return _obras.fold(
      0,
      (total, obra) => total + obra.favoritos,
    );
  }

  int get totalCapitulos {
    return _obras.fold(
      0,
      (total, obra) => total + obra.capitulos.length,
    );
  }

  double get mediaAvaliacoes {
    if (_obras.isEmpty) return 0;

    double soma = 0;

    for (final obra in _obras) {
      soma += obra.avaliacao;
    }

    return soma / _obras.length;
  }

  List<ObraModel> get obrasEmAlta {
    final lista = List<ObraModel>.from(_obras);

    lista.sort(
      (a, b) => b.visualizacoes.compareTo(
        a.visualizacoes,
      ),
    );

    return lista.take(10).toList();
  }
}
