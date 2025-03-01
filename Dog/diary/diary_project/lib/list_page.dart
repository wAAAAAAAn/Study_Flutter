import 'dart:convert';
import './constant/_url.dart' as url;

import 'package:diary_project/diary.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Diary> list = [];

  Future<void> _deleteDiary(String id) async {
    print(id);
    final Uri uri = Uri.parse("${url.url}/board/delete/$id");
    await http.delete(uri);
  }

  void _showDeleteDialog(
      BuildContext context, String id, String correctPassword) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("비밀번호 확인"),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "비밀번호 입력"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () async {
                if (passwordController.text == correctPassword) {
                  _deleteDiary(id);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("비밀번호가 틀렸습니다.")),
                  );
                }
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    Uri uri = Uri.parse("${url.url}/board/list");
    http.get(uri, headers: {
      "Content-Type": "application/json",
    }).then(
      (value) {
        setState(() {
          var dynamicList = jsonDecode(utf8.decode(value.bodyBytes));
          for (dynamic val in dynamicList) {
            list.add(Diary.parseJson(val));
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("간단한 일기장"), backgroundColor: Color(0xFF8D6E63)),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final diary = list[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: _buildFrontCard(diary.title),
              back: _buildBackCard(diary),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard(String title) {
    return Card(
      elevation: 5,
      color: Color(0xFFFAF3E0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown)),
      ),
    );
  }

  Widget _buildBackCard(Diary diary) {
    return Card(
      elevation: 5,
      color: Color(0xFFFAF3E0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(diary.title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
            SizedBox(height: 10),
            Text(diary.content,
                style: TextStyle(fontSize: 18, color: Colors.black87)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () =>
                  _showDeleteDialog(context, diary.id, diary.password),
              icon: Icon(Icons.delete, color: Colors.white),
              label: Text("삭제", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5D4037),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
