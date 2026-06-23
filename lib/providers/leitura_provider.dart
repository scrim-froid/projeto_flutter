import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/models/leitura_model.dart';
import '../services/storage_service.dart';

class LeituraProvider extends ChangeNotifier {
  LeituraModel? leituraAtual;

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

    await StorageService.saveString(
      'ultima_leitura',
      jsonEncode(leitura.toJson()),
    );

    notifyListeners();
  }
}