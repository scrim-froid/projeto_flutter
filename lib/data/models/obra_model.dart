import 'package:projeto_flutter/data/models/capitulo_model.dart';

class ObraModel {
  String id;

  String titulo;
  String autor;

  String autorId;
  String autorNome;

  String capa;
  String genero;

  double avaliacao;

  String sinopse;

  int visualizacoes;
  int favoritos;
  int totalAvaliacoes;

  List<CapituloModel> capitulos;

  ObraModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.autorId,
    required this.autorNome,
    required this.capa,
    required this.genero,
    required this.avaliacao,
    required this.sinopse,
    required this.capitulos,
    this.visualizacoes = 0,
    this.favoritos = 0,
    this.totalAvaliacoes = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'autorId': autorId,
      'autorNome': autorNome,
      'capa': capa,
      'genero': genero,
      'avaliacao': avaliacao,
      'sinopse': sinopse,
      'visualizacoes': visualizacoes,
      'favoritos': favoritos,
      'totalAvaliacoes': totalAvaliacoes,
      'capitulos': capitulos
          .map(
            (capitulo) => capitulo.toJson(),
          )
          .toList(),
    };
  }

  factory ObraModel.fromJson(
    Map<String, dynamic> json, {
    String id = '',
  }) {
    return ObraModel(
      id: id,
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      autorId: json['autorId'] ?? '',
      autorNome: json['autorNome'] ?? '',
      capa: json['capa'] ?? '',
      genero: json['genero'] ?? '',
      avaliacao: (json['avaliacao'] ?? 0).toDouble(),
      sinopse: json['sinopse'] ?? '',
      visualizacoes: json['visualizacoes'] ?? 0,
      favoritos: json['favoritos'] ?? 0,
      totalAvaliacoes: json['totalAvaliacoes'] ?? 0,
      capitulos: (json['capitulos'] as List?)
              ?.map(
                (e) => CapituloModel.fromJson(
                  e,
                ),
              )
              .toList() ??
          [],
    );
  }
}
