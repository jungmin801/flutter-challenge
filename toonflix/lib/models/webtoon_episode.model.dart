class WebtoonEpisodeModel {
  final String id, rating, title, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      id = json['id'],
      rating = json['rating'],
      date = json['date'];
}
