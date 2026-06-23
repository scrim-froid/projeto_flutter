class CapituloModel {
  final int numero;
  final String titulo;
  final List<String> paginas;

  const CapituloModel({
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
    Map<String, dynamic> json,
  ) {
    return CapituloModel(
      numero: json['numero'],
      titulo: json['titulo'],
      paginas: List<String>.from(
        json['paginas'],
      ),
    );
  }
}