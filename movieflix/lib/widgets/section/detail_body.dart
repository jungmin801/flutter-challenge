import 'package:flutter/material.dart';
import 'package:movieflix/models/detail_movie_model.dart';

class DetailBodyWidget extends StatelessWidget {
  final DetailMovieModel data;

  const DetailBodyWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Storyline',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          data.overview,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
