import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_flutter/presentation/screens/comments/comments_screen.dart';
import 'package:projeto_flutter/presentation/screens/profile/author_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/screens/upload/create_chapter_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/obra_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/obra_model.dart';
import '../../../providers/favoritos_provider.dart';
import '../reader/reader_screen.dart';

class ObraDetailScreen extends StatefulWidget {
  final ObraModel obra;

  const ObraDetailScreen({
    super.key,
    required this.obra,
  });

  @override
  State<ObraDetailScreen> createState() => _ObraDetailScreenState();
}

class _ObraDetailScreenState extends State<ObraDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ObraProvider>().incrementarVisualizacao(
            widget.obra,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.obra.capa.isNotEmpty
                  ? widget.obra.capa.isNotEmpty
                      ? Image.network(
                          widget.obra.capa,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 250,
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(
                              Icons.menu_book,
                              size: 80,
                            ),
                          ),
                        )
                  : Container(
                      color: Colors.grey.shade800,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.obra.titulo,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuthorProfileScreen(
                            autorId: widget.obra.autorId,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      widget.obra.autorNome,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          widget.obra.genero,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.obra.avaliacao.toStringAsFixed(1),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${widget.obra.totalAvaliacoes})',
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.obra.avaliacao.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Sinopse",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.obra.sinopse,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.comment),
                    label: const Text(
                      'Comentários',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentsScreen(
                            obra: widget.obra,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<FavoritosProvider>(
                          builder: (
                            context,
                            favoritos,
                            child,
                          ) {
                            final isFavorito = favoritos.isFavorito(
                              widget.obra.id,
                            );

                            final uid = FirebaseAuth.instance.currentUser!.uid;

                            return FilledButton.icon(
                              onPressed: () async {
                                await favoritos.toggleFavorito(
                                  uid: uid,
                                  obra: widget.obra,
                                );
                              },
                              icon: Icon(
                                isFavorito
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                              label: Text(
                                isFavorito ? 'Favoritado' : 'Favoritar',
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            if (widget.obra.capitulos.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Esta obra ainda não possui capítulos.',
                                  ),
                                ),
                              );
                              return;
                            }

                            final obraIndex = context
                                .read<ObraProvider>()
                                .obras
                                .indexOf(widget.obra);

                            widget.obra.visualizacoes++;

                            await context
                                .read<ObraProvider>()
                                .atualizarObra(widget.obra);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReaderScreen(
                                  obra: widget.obra,
                                  capitulo: widget.obra.capitulos.first,
                                  obraIndex: obraIndex,
                                  capituloIndex: 0,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.menu_book,
                          ),
                          label: const Text("Ler"),
                        ),
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateChapterScreen(
                            obra: widget.obra,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      'Novo Capítulo',
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Capítulos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (widget.obra.capitulos.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Nenhum capítulo publicado.',
                        ),
                      ),
                    ),
                  ...widget.obra.capitulos.asMap().entries.map(
                    (entry) {
                      final capituloIndex = entry.key;
                      final capitulo = entry.value;

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              capitulo.numero.toString(),
                            ),
                          ),
                          title: Text(
                            capitulo.titulo,
                          ),
                          subtitle: Text(
                            '${capitulo.paginas.length} páginas',
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            final obraIndex = context
                                .read<ObraProvider>()
                                .obras
                                .indexOf(widget.obra);
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.obra.avaliacao.toStringAsFixed(1),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                    Text(
                                      widget.obra.avaliacao.toStringAsFixed(1),
                                    ),
                                    Text(
                                      '${widget.obra.totalAvaliacoes} avaliações',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReaderScreen(
                                  obra: widget.obra,
                                  capitulo: capitulo,
                                  obraIndex: obraIndex,
                                  capituloIndex: capituloIndex,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
