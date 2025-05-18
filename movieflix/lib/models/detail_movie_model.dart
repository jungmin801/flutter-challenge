class DetailMovieModel {
  final String poster, title, overview;
  final int runtime;
  final double voteAvg;
  final List<String> genres;

  DetailMovieModel.fromJson(Map<String, dynamic> json)
    : poster = json['poster_path'],
      title = json["title"],
      overview = json["overview"],
      runtime = json["runtime"],
      voteAvg = (json["vote_average"] as num).toDouble(),
      genres =
          (json["genres"] as List).map((e) => e["name"] as String).toList();
}
