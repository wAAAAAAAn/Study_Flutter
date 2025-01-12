import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/screens/episode_screen.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key, required this.id, required this.title, required this.thumb});
  final String id, title, thumb;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetail> webDetail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  List<String>? likedToons = [];

  late SharedPreferences prefs;
  bool isLiked = false;
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    likedToons = prefs.getStringList('likedToons');
    if (likedToons == null) {
      await prefs.setStringList('likedToons', []);
      likedToons = [];
    } else {
      setState(() {
        if (likedToons!.contains(widget.id)) {
          isLiked = true;
        } else {
          false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    webDetail = ApiService.getToonById(widget.id);
    episodes = ApiService.getLastestEpisodeById(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(
            //title앞에 붙은 widget은 DetailScreen(부모로 부터) 에서 받아오 변수들을 의미한다.
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                if (isLiked) {
                  likedToons!.remove(widget.id);
                } else {
                  likedToons!.add(widget.id);
                }
                await prefs.setStringList('likedToons', likedToons!);
                setState(() {
                  isLiked = !isLiked;
                });
              },
              icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_outline_outlined),
            ),
          ],
        ),
        body: Hero(
          tag: widget.id,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      //얼마나 멀리 퍼질지 확인하는 것
                                      blurRadius: 15,
                                      //해가 어느 방향에서 오는지 설정하는것
                                      offset: Offset(10, 15),
                                      color: const Color.fromARGB(54, 0, 0, 0))
                                ]),
                            clipBehavior: Clip.hardEdge,
                            width: 250,
                            child: Image.network(
                              widget.thumb,
                              headers: const {
                                "User-Agent":
                                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                      future: webDetail,
                      builder: (context, snpashot) {
                        if (snpashot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snpashot.data!.about,
                                  style: const TextStyle(fontSize: 16)),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "${snpashot.data!.genre} / ${snpashot.data!.age}",
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          );
                        }
                        return Expanded(child: Text('...'));
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: episodes,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              for (var episode in snapshot.data!)
                                episode_widget(
                                  episode: episode,
                                  webtoonId: widget.id,
                                )
                            ],
                          );
                        }
                        return Container();
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
