import 'dart:convert';

import 'package:diary_project/constant/_url.dart' as url;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController title = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController contents = TextEditingController();

  void _showAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("알림"),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 창 닫기
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    title.dispose();
    password.dispose();
    contents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("간단한 일기장"),
        backgroundColor: Color(0xFF8D6E63), // 고급스러운 브라운
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildInputField("제목", title),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildInputField("비밀번호", password, obscureText: true),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField("일기 내용 입력", contents, maxLines: 10),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (title.text.isEmpty) {
                    _showAlertDialog(context, '제목이 비어있습니다.');
                    return;
                  }
                  if (contents.text.isEmpty) {
                    _showAlertDialog(context, '내용이 비어있습니다.');
                    return;
                  }
                  if (password.text.isEmpty) {
                    _showAlertDialog(context, '비밀번호가 비어있습니다.');
                    return;
                  }
                  final Uri uri = Uri.parse("${url.url}/board/insert");
                  final headers = {"Content-Type": "application/json"};
                  await http
                      .post(uri,
                          headers: headers,
                          body: jsonEncode({
                            "title": title.text,
                            "contents": contents.text,
                            "password": password.text
                          }))
                      .then((value) {
                    _showAlertDialog(context, '성공');
                    Navigator.pop(context);
                  }, onError: (error) {
                    _showAlertDialog(context, '실패');
                  });
                },
                icon: Icon(Icons.save, color: Colors.white),
                label: Text("저장", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5D4037), // 어두운 브라운
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller,
      {bool obscureText = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.brown),
        filled: true,
        fillColor: Color(0xFFFAF3E0), // 크림색
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.brown),
        ),
      ),
    );
  }
}
