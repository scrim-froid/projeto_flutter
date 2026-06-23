import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/models/capitulo_model.dart';
import '../data/models/obra_model.dart';
import '../data/mock/mock_obras.dart';

class ObraProvider extends ChangeNotifier {
  final List<ObraModel> _obras = [...mockObras];

  List<ObraModel> get obras => _obras;

  void adicionarObra(ObraModel obra) {
    _obras.add(obra);
    notifyListeners();
  }

  void adicionarCapitulo(
    ObraModel obra,
    CapituloModel capitulo,
  ) {
    final index = _obras.indexOf(obra);

    if (index != -1) {
      _obras[index].capitulos.add(capitulo);
      notifyListeners();
    }
  }
}
