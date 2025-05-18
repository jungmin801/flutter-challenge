import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:movieflix/models/detail_movie_model.dart';
import 'package:movieflix/models/home_movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  static final popular = 'popular';
  static final nowPlaying = 'now-playing';
  static final comingSoon = 'coming-soon';

  static Future<List<HomeMovieModel>> getPopularMovies() async {
    List<HomeMovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(HomeMovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<List<HomeMovieModel>> getNowPlayings() async {
    List<HomeMovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(HomeMovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<List<HomeMovieModel>> getComingSoons() async {
    List<HomeMovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(HomeMovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<DetailMovieModel> getMovieById(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movie = jsonDecode(response.body);
      return DetailMovieModel.fromJson(movie);
    }
    throw Error();
  }
}
