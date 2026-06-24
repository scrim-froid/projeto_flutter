class LeituraModel {
  final String obraTitulo;
  final String capituloTitulo;

  final int obraIndex;
  final int capituloIndex;

  final int paginaAtual;
  final int totalPaginas;

  LeituraModel({
    required this.obraTitulo,
    required this.capituloTitulo,
    required this.obraIndex,
    required this.capituloIndex,
    required this.paginaAtual,
    required this.totalPaginas,
  });

  Map<String, dynamic> toJson() {
    return {
      'obraTitulo': obraTitulo,
      'capituloTitulo': capituloTitulo,
      'obraIndex': obraIndex,
      'capituloIndex': capituloIndex,
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
      obraIndex: json['obraIndex'],
      capituloIndex: json['capituloIndex'],
      paginaAtual: json['paginaAtual'],
      totalPaginas: json['totalPaginas'],
    );
  }
}