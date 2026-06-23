import 'package:flutter/material.dart';
import '../data/models/obra_model.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<ObraModel> _favoritos = [];

  List<ObraModel> get favoritos => _favoritos;

  bool isFavorito(ObraModel obra) {
    return _favoritos.contains(obra);
  }

  void toggleFavorito(ObraModel obra) {
    if (_favoritos.contains(obra)) {
      _favoritos.remove(obra);
    } else {
      _favoritos.add(obra);
    }

    notifyListeners();
  }
}