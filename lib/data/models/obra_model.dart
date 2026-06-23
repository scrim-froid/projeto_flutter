import 'capitulo_model.dart';

class ObraModel {
  String titulo;
  String autor;
  String capa;
  String genero;
  double avaliacao;
  String sinopse;

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

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'capa': capa,
      'genero': genero,
      'avaliacao': avaliacao,
      'sinopse': sinopse,

      'capitulos': capitulos
          .map((capitulo) => capitulo.toJson())
          .toList(),
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

      avaliacao:
          (json['avaliacao'] as num)
              .toDouble(),

      sinopse: json['sinopse'],

      capitulos:
          (json['capitulos'] as List?)
                  ?.map(
                    (capitulo) =>
                        CapituloModel.fromJson(
                      capitulo,
                    ),
                  )
                  .toList() ??
              [],
    );
  }
}