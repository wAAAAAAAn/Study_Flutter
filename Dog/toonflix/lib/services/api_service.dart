import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static final String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev/";
  static final String today = 'today';
  static List<WebtoonModel> webToonList = [];
  static Future<List<WebtoonModel>> getTodatysToons() async {
    Uri url = Uri.parse(baseUrl + today);
    //javascript 처럼 await async를 통해 동기 처리가 가능하다.
    //Future<Response>타입은 보통 await랑 같이 사용된다. 이는 바로 결과가 나오는 것이 아닌 미래에 Response가 반환될 거라는 것을 의미한다.
    //여기서는 await를 통해 Future가 끝날때까지 있다가 response가 나온후 반환된다.
    final response = await http.get(url);

    // javascript에서 Promise와 같다.
    // print("A");
    // http.get(url).then((var e) {
    //   print(e);
    //   print("is returned");
    // });
    // print("B");
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var i in webtoons) {
        final toon = WebtoonModel.fromJson(i);
        webToonList.add(toon);
      }
      return webToonList;
    }
    throw Error();
  }

  static Future<WebtoonDetail> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetail.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLastestEpisodeById(
      String id) async {
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    List<WebtoonEpisodeModel> webtoonEpisoe = [];
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        webtoonEpisoe.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return webtoonEpisoe;
    }
    throw Error();
  }
}
