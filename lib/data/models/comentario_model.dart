import 'package:cloud_firestore/cloud_firestore.dart';

class ComentarioModel {
  final String id;
  final String uid;
  final String nome;
  final String texto;
  final int nota;
  final DateTime data;

  ComentarioModel({
    required this.id,
    required this.uid,
    required this.nome,
    required this.texto,
    required this.nota,
    required this.data,
  });

  factory ComentarioModel.fromJson(
  Map<String, dynamic> json,
  String id,
) {
  return ComentarioModel(
    id: id,
    uid: json['uid'] ?? '',
    nome: json['nome'] ?? '',
    texto: json['texto'] ?? '',
    nota: json['nota'] ?? 0,
    data: json['data'] != null
        ? (json['data'] as Timestamp)
            .toDate()
        : DateTime.now(),
  );
}

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nome': nome,
      'texto': texto,
      'nota': nota,
      'data': Timestamp.now(),
    };
  }
}