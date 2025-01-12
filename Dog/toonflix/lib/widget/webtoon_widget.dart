import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  const WebtoonWidget({super.key, required this.webtoon});
  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigator는 특정 widget을 screen처럼 보이게 하는 역할은 한다.
        //route를 통해 widget을 screen처럼 보이게 한다.
        //MaterialPageRoute 의 builder에서 반환하는 widget을 screen 처럼 보이게 한다.
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                  id: webtoon.id, title: webtoon.title, thumb: webtoon.thumb),
              fullscreenDialog: false,
            ));
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
            child: Container(
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
                webtoon.thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            webtoon.title,
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
  }
}
