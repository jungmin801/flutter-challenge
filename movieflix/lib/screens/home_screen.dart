import 'package:flutter/material.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:movieflix/services/api_services.dart';
import 'package:movieflix/widgets/section/coming_soon.dart';
import 'package:movieflix/widgets/section/now_playing.dart';
import 'package:movieflix/widgets/section/popular_movies.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const imgUrl = "https://image.tmdb.org/t/p/w500";

  final Future<List<HomeMovieModel>> populars = ApiServices.getPopularMovies();
  final Future<List<HomeMovieModel>> nowPlayings = ApiServices.getNowPlayings();
  final Future<List<HomeMovieModel>> comingSoons = ApiServices.getComingSoons();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopularMoviesWidget(populars: populars, imgUrl: imgUrl),
                NowPlayingMoviesWidget(
                  nowPlayings: nowPlayings,
                  imgUrl: imgUrl,
                ),
                ComingSoonMoviesWidget(
                  comingSoons: comingSoons,
                  imgUrl: imgUrl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
