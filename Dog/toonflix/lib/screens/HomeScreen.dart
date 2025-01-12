import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widget/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodatysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          '오늘의 웹툰',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [SizedBox(height: 50), makeList(snapshot)],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Expanded makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var webtoon = snapshot.data![index];
          return WebtoonWidget(
            webtoon: webtoon,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 40,
        ),
      ),
    );
  }
}
