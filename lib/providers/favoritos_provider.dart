import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/models/obra_model.dart';
import '../services/storage_service.dart';

class FavoritosProvider extends ChangeNotifier {

  final List<ObraModel> _favoritos = [];

  List<ObraModel> get favoritos => _favoritos;

  bool isFavorito(ObraModel obra) {
    return _favoritos.any(
      (favorito) => favorito.titulo == obra.titulo,
    );
  }

  Future<void> salvarFavoritos() async {

    final titulos = _favoritos
        .map((obra) => obra.titulo)
        .toList();

    await StorageService.saveString(
      'favoritos',
      jsonEncode(titulos),
    );
  }

  Future<void> carregarFavoritos(
    List<ObraModel> obras,
  ) async {

    final data =
        await StorageService.getString(
      'favoritos',
    );

    if (data == null) return;

    final List lista =
        jsonDecode(data);

    _favoritos.clear();

    for (final obra in obras) {
      if (lista.contains(obra.titulo)) {
        _favoritos.add(obra);
      }
    }

    notifyListeners();
  }

  Future<void> toggleFavorito(
    ObraModel obra,
  ) async {

    if (isFavorito(obra)) {
      _favoritos.removeWhere(
        (favorito) =>
            favorito.titulo == obra.titulo,
      );
    } else {
      _favoritos.add(obra);
    }

    await salvarFavoritos();

    notifyListeners();
  }
}