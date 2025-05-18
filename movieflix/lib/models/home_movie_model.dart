class HomeMovieModel {
  final String title, backdropPath, poster;
  final int id;

  HomeMovieModel.fromJson(Map<String, dynamic> json)
    : backdropPath = json['backdrop_path'] ?? '',
      poster = json['poster_path'] ?? '',
      title = json['title'] ?? 'No Title',
      id = json["id"] ?? 0;
}
