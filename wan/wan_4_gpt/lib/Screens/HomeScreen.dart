import 'package:flutter/material.dart';
import 'package:wan_3_webtoon/widgets/ButtonGrid.dart';
import 'package:wan_3_webtoon/widgets/GPTQuestionWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedTitle = "선택된 아이템 없음"; // 초기값
  final TextEditingController _textController =
      TextEditingController(); // 텍스트 필드 컨트롤러

  // ButtonGrid에서 선택된 타이틀을 업데이트하는 함수
  void _updateSelectedTitle(String title) {
    setState(() {
      _selectedTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "이 옷 뭐임",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ButtonGrid(
              onItemSelected: _updateSelectedTitle, // 콜백 전달
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
