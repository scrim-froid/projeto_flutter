import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/models/capitulo_model.dart';
import '../data/models/obra_model.dart';
import '../data/mock/mock_obras.dart';
import '../services/storage_service.dart';

class ObraProvider extends ChangeNotifier {
  ObraProvider() {
    carregarObras();
  }

  final List<ObraModel> _obras = [...mockObras];

  List<ObraModel> get obras => _obras;

  Future<void> salvarObras() async {
    final jsonString = jsonEncode(
      _obras.map((e) => e.toJson()).toList(),
    );

    await StorageService.saveString(
      'obras',
      jsonString,
    );
  }

  Future<void> carregarObras() async {
    final data = await StorageService.getString(
      'obras',
    );

    if (data == null) return;

    final List lista = jsonDecode(data);

    _obras.clear();

    _obras.addAll(
      lista.map(
        (e) => ObraModel.fromJson(e),
      ),
    );

    notifyListeners();
  }

  Future<void> adicionarObra(
    ObraModel obra,
  ) async {
    _obras.add(obra);

    await salvarObras();

    notifyListeners();
  }

  Future<void> adicionarCapitulo(
    ObraModel obra,
    CapituloModel capitulo,
  ) async {
    final index = _obras.indexOf(obra);

    if (index != -1) {
      _obras[index].capitulos.add(
            capitulo,
          );

      await salvarObras();

      notifyListeners();
    }
  }

  Future<void> removerObra(
    ObraModel obra,
  ) async {
    _obras.remove(obra);

    await salvarObras();

    notifyListeners();
  }

  Future<void> atualizarObra() async {
    await salvarObras();
    notifyListeners();
  }
}
