class CapituloModel {
  final String? id;
  final int numero;
  final String titulo;
  final List<String> paginas;

  const CapituloModel({
    this.id,
    required this.numero,
    required this.titulo,
    required this.paginas,
  });

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'titulo': titulo,
      'paginas': paginas,
    };
  }

  factory CapituloModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return CapituloModel(
      id: id,
      numero: json['numero'],
      titulo: json['titulo'],
      paginas: List<String>.from(json['paginas'] ?? []),
    );
  }
}