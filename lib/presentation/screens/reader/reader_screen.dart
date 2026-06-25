import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_flutter/services/capitulo_service.dart';
import 'package:provider/provider.dart';

import '../../../data/models/capitulo_model.dart';
import '../../../data/models/leitura_model.dart';
import '../../../data/models/obra_model.dart';
import '../../../providers/leitura_provider.dart';

class ReaderScreen extends StatefulWidget {
  final ObraModel obra;
  final CapituloModel capitulo;

  final int obraIndex;
  final int capituloIndex;
  final int paginaInicial;

  const ReaderScreen({
    super.key,
    required this.obra,
    required this.capitulo,
    required this.obraIndex,
    required this.capituloIndex,
    this.paginaInicial = 0,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late PageController _controller;
  late int currentPage;

  final CapituloService _service = CapituloService();

  bool showUI = true;

  late Future<CapituloModel> _capituloFuture;

  // 🔥 BUSCA CAPÍTULO ATUALIZADO NO FIRESTORE
  Future<CapituloModel> carregarCapitulo() async {
    final doc = await FirebaseFirestore.instance
        .collection('obras')
        .doc(widget.obra.id)
        .collection('capitulos')
        .doc(widget.capitulo.id)
        .get();

    if (!doc.exists) {
      throw Exception('Capítulo não encontrado');
    }

    return CapituloModel.fromJson(doc.data()!);
  }

  @override
  void initState() {
    super.initState();

    currentPage = widget.paginaInicial;

    _controller = PageController(initialPage: widget.paginaInicial);

    _capituloFuture = _service.buscarCapitulo(
      obraId: widget.obra.id!,
      capituloId: widget.capitulo.id!,
    );

    currentPage = widget.paginaInicial;

    _controller = PageController(
      initialPage: widget.paginaInicial,
    );

    _capituloFuture = carregarCapitulo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPagina(String caminho) {
    if (caminho.startsWith('http')) {
      return Image.network(
        caminho,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    if (caminho.startsWith('assets/')) {
      return Image.asset(caminho, fit: BoxFit.contain);
    }

    return Image.file(
      File(caminho),
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CapituloModel>(
      future: _capituloFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Erro ao carregar capítulo')),
          );
        }

        final capitulo = snapshot.data!;

        if (capitulo.paginas.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(capitulo.titulo)),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_stories, size: 80),
                  SizedBox(height: 16),
                  Text('Este capítulo ainda não possui páginas.'),
                ],
              ),
            ),
          );
        }

        return _buildReader(capitulo);
      },
    );
  }

  Widget _buildReader(CapituloModel capitulo) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            showUI = !showUI;
          });
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: capitulo.paginas.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });

                context.read<LeituraProvider>().salvarLeitura(
                      LeituraModel(
                        obraTitulo: widget.obra.titulo,
                        capituloTitulo: capitulo.titulo,
                        obraIndex: widget.obraIndex,
                        capituloIndex: widget.capituloIndex,
                        paginaAtual: index,
                        totalPaginas: capitulo.paginas.length,
                      ),
                    );
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: _buildPagina(capitulo.paginas[index]),
                  ),
                );
              },
            ),
            if (showUI)
              Positioned(
                top: 40,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            if (showUI)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentPage + 1} / ${capitulo.paginas.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
