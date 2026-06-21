import 'package:flutter/material.dart';
import '../data/models/obra_model.dart';

class FavoritosProvider extends ChangeNotifier {

  final List<ObraModel> _favoritos = [];

  List<ObraModel> get favoritos => _favoritos;

  bool isFavorito(ObraModel obra) {
    return _favoritos.any(
      (item) => item.titulo == obra.titulo,
    );
  }

  void toggleFavorito(
    ObraModel obra,
  ) {
    if (isFavorito(obra)) {
      _favoritos.removeWhere(
        (item) =>
            item.titulo == obra.titulo,
      );
    } else {
      _favoritos.add(obra);
    }

    notifyListeners();
  }
}