import 'package:flutter/material.dart';
import 'package:movieflix/models/detail_movie_model.dart';

class DetailHeaderWidget extends StatelessWidget {
  final DetailMovieModel data;

  const DetailHeaderWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            SizedBox(width: 4),
            Text(
              '${data.voteAvg}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          '${data.runtime} min | ${data.genres.join(', ')}',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
