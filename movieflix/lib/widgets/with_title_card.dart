import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';

class WithTitleCard extends StatelessWidget {
  const WithTitleCard({super.key, required this.movie, required this.imgUrl});

  final HomeMovieModel movie;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: GestureDetector(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 8,
                    offset: Offset(5, 5),
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Image.network(
                '$imgUrl${movie.poster}',
                fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 채워지도록 함
                width: 140, // 너비 지정
                height: 220, // 높이 지정 (컨테이너와 동일하게)
              ),
            ),
            SizedBox(height: 6),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
