import 'package:flutter/material.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() =>
      _ReaderScreenState();
}

class _ReaderScreenState
    extends State<ReaderScreen> {

  final PageController _controller =
      PageController();

  bool showUI = true;

  int currentPage = 0;

  final List<String> pages = [
    'https://picsum.photos/500/800?1',
    'https://picsum.photos/500/800?2',
    'https://picsum.photos/500/800?3',
    'https://picsum.photos/500/800?4',
    'https://picsum.photos/500/800?5',
  ];

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

              itemCount: pages.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,

                  child: Image.network(
                    pages[index],
                    fit: BoxFit.contain,
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
                      Navigator.pop(context);
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
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.black54,

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Text(
                      "${currentPage + 1} / ${pages.length}",

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