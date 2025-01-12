class WebtoonEpisodeModel {
  final String id, title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        id = json['id'],
        title = json['title'],
        rating = json['rating'];
}
