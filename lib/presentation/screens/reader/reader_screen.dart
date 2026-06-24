import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/models/capitulo_model.dart';
import 'package:projeto_flutter/data/models/obra_model.dart';
import 'package:provider/provider.dart';
import '../../../providers/leitura_provider.dart';
import '../../../data/models/leitura_model.dart';

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

  bool showUI = true;

  @override
  void initState() {
    super.initState();

    currentPage = widget.paginaInicial;

    _controller = PageController(
      initialPage: widget.paginaInicial,
    );
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
        loadingBuilder: (
          context,
          child,
          progress,
        ) {
          if (progress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    if (caminho.startsWith('assets/')) {
      return Image.asset(
        caminho,
        fit: BoxFit.contain,
      );
    }

    return Image.file(
      File(caminho),
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: widget.capitulo.paginas.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });

                context.read<LeituraProvider>().salvarLeitura(
                      LeituraModel(
                        obraTitulo: widget.obra.titulo,
                        capituloTitulo: widget.capitulo.titulo,
                        obraIndex: widget.obraIndex,
                        capituloIndex: widget.capituloIndex,
                        paginaAtual: index,
                        totalPaginas: widget.capitulo.paginas.length,
                      ),
                    );
              },
              itemBuilder: (
                context,
                index,
              ) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: _buildPagina(
                      widget.capitulo.paginas[index],
                    ),
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
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
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      '${currentPage + 1} / ${widget.capitulo.paginas.length}',
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
