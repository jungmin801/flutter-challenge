import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';

class OnlyImageCard extends StatelessWidget {
  const OnlyImageCard({super.key, required this.movie, required this.imgUrl});

  final HomeMovieModel movie;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailScreen(
                  id: movie.id,
                  poster: movie.poster,
                  imgUrl: imgUrl,
                ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 180,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  color: Colors.black12,
                ),
              ],
            ),
            child:
                movie.backdropPath.isEmpty
                    ? Placeholder(fallbackHeight: 140, fallbackWidth: 240)
                    : Image.network("$imgUrl${movie.backdropPath}"),
          ),
        ],
      ),
    );
  }
}
