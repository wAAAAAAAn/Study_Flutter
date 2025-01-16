import 'package:flutter/material.dart';
import 'package:wan_3_webtoon/button_data_model.dart';
import 'package:wan_3_webtoon/widgets/GPTQuestionWidget.dart';

class ImageDetailPage extends StatelessWidget {
  final ButtonData data;

  const ImageDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Hero(
          tag: data.imagePath,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  data.imagePath,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width, // 화면 너비에 맞춤
                  height:
                      MediaQuery.of(context).size.height * 0.5, // 화면 높이 일부 차지
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: 400, // 고정된 높이 설정
                  child: GPTQuestionWidget(productName: data.title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
