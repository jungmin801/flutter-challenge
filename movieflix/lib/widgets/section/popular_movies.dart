import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/widgets/only_image_card.dart';

class PopularMoviesWidget extends StatelessWidget {
  final Future<List<HomeMovieModel>> populars;
  final String imgUrl;

  const PopularMoviesWidget({
    super.key,
    required this.populars,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 100),
        Text(
          'Popular Movies',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: FutureBuilder(
            future: populars,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _renderPopularList(snapshot);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  ListView _renderPopularList(AsyncSnapshot<List<HomeMovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final movie = snapshot.data![index];
        return OnlyImageCard(movie: movie, imgUrl: imgUrl);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 20);
      },
      itemCount: snapshot.data!.length,
    );
  }
}
