import 'capitulo_model.dart';

class ObraModel {
  final String titulo;
  final String autor;
  final String capa;
  final String genero;
  final double avaliacao;
  final String sinopse;

  List<CapituloModel> capitulos;

  ObraModel({
    required this.titulo,
    required this.autor,
    required this.capa,
    required this.genero,
    required this.avaliacao,
    required this.sinopse,
    required this.capitulos,
  });
}
