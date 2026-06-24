import 'capitulo_model.dart';

class ObraModel {
  String titulo;
  String autor;
  final String capa;
  String genero;
  double avaliacao;
  String sinopse;

  int visualizacoes;
  int favoritos;

  List<CapituloModel> capitulos;

  ObraModel({
    required this.titulo,
    required this.autor,
    required this.capa,
    required this.genero,
    required this.avaliacao,
    required this.sinopse,
    required this.capitulos,
    this.visualizacoes = 0,
    this.favoritos = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'capa': capa,
      'genero': genero,
      'avaliacao': avaliacao,
      'sinopse': sinopse,
      'visualizacoes': visualizacoes,
      'favoritos': favoritos,
      'capitulos': capitulos.map((capitulo) => capitulo.toJson()).toList(),
    };
  }

  factory ObraModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ObraModel(
      titulo: json['titulo'],
      autor: json['autor'],
      capa: json['capa'],
      genero: json['genero'],
      avaliacao: (json['avaliacao'] as num).toDouble(),
      sinopse: json['sinopse'],
      capitulos: (json['capitulos'] as List?)
              ?.map(
                (capitulo) => CapituloModel.fromJson(
                  capitulo,
                ),
              )
              .toList() ??
          [],
      visualizacoes: json['visualizacoes'] ?? 0,
      favoritos: json['favoritos'] ?? 0,
    );
  }
}
