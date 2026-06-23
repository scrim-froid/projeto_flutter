class LeituraModel {
  final String obraTitulo;
  final String capituloTitulo;
  final int paginaAtual;
  final int totalPaginas;

  LeituraModel({
    required this.obraTitulo,
    required this.capituloTitulo,
    required this.paginaAtual,
    required this.totalPaginas,
  });

  Map<String, dynamic> toJson() {
    return {
      'obraTitulo': obraTitulo,
      'capituloTitulo': capituloTitulo,
      'paginaAtual': paginaAtual,
      'totalPaginas': totalPaginas,
    };
  }

  factory LeituraModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LeituraModel(
      obraTitulo: json['obraTitulo'],
      capituloTitulo: json['capituloTitulo'],
      paginaAtual: json['paginaAtual'],
      totalPaginas: json['totalPaginas'],
    );
  }
}