import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/widgets/with_title_card.dart';

class NowPlayingMoviesWidget extends StatelessWidget {
  final Future<List<HomeMovieModel>> nowPlayings;
  final String imgUrl;

  const NowPlayingMoviesWidget({
    super.key,
    required this.nowPlayings,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Now In Cinemas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: FutureBuilder(
            future: nowPlayings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _renderNowPlayingList(snapshot);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  ListView _renderNowPlayingList(AsyncSnapshot<List<HomeMovieModel>> snapshot) {
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
