import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class WebtoonCard extends StatelessWidget {
  final String title, thumb, id;
  const WebtoonCard({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailScreen(thumb: thumb, title: title, id: id),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 15,
                    offset: Offset(10, 10),
                    color: Colors.black38,
                  ),
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(height: 14),
          Text(title, style: const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
