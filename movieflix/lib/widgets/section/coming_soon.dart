import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/widgets/with_title_card.dart';

class ComingSoonMoviesWidget extends StatelessWidget {
  final Future<List<HomeMovieModel>> comingSoons;
  final String imgUrl;

  const ComingSoonMoviesWidget({
    super.key,
    required this.comingSoons,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Coming Soon',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: FutureBuilder(
            future: comingSoons,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _renderComingSoonList(snapshot);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  ListView _renderComingSoonList(AsyncSnapshot<List<HomeMovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final movie = snapshot.data![index];
        return WithTitleCard(movie: movie, imgUrl: imgUrl);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 20);
      },
      itemCount: snapshot.data!.length,
    );
  }
}
