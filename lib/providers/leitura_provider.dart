import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/models/leitura_model.dart';
import '../services/storage_service.dart';

class LeituraProvider extends ChangeNotifier {
  LeituraProvider() {
    carregarLeitura();
    carregarHistorico();
  }

  LeituraModel? leituraAtual;

  final List<LeituraModel> historico = [];

  Future<void> carregarLeitura() async {
    final data = await StorageService.getString(
      'ultima_leitura',
    );

    if (data == null) return;

    leituraAtual = LeituraModel.fromJson(
      jsonDecode(data),
    );

    notifyListeners();
  }

  Future<void> salvarLeitura(
    LeituraModel leitura,
  ) async {
    leituraAtual = leitura;

    historico.removeWhere(
      (item) =>
          item.obraTitulo == leitura.obraTitulo &&
          item.capituloTitulo == leitura.capituloTitulo,
    );

    historico.insert(
      0,
      leitura,
    );

    if (historico.length > 50) {
      historico.removeLast();
    }

    await StorageService.saveString(
      'ultima_leitura',
      jsonEncode(leitura.toJson()),
    );

    await StorageService.saveString(
      'historico_leitura',
      jsonEncode(
        historico
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      ),
    );

    notifyListeners();
  }

  Future carregarHistorico() async {
    final data = await StorageService.getString(
      'historico_leitura',
    );

    if (data == null) return;

    final List lista = jsonDecode(data);

    historico.clear();

    historico.addAll(
      lista.map(
        (e) => LeituraModel.fromJson(e),
      ),
    );

    notifyListeners();
  }
}
