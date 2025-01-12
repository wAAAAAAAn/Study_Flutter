import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class episode_widget extends StatelessWidget {
  const episode_widget({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;
  void onButtontonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtontonTap,
      child: Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.green, width: 6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  episode.title,
                  style: TextStyle(
                      color: Colors.green[400], fontWeight: FontWeight.w900),
                ),
                Icon(Icons.chevron_right_rounded),
              ],
            ),
          )),
    );
  }
}
