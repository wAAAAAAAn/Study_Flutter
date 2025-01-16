import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GPTQuestionWidget extends StatefulWidget {
  final String productName;

  const GPTQuestionWidget({
    super.key,
    required this.productName,
  });

  @override
  State<GPTQuestionWidget> createState() => _GPTQuestionWidgetState();
}

class _GPTQuestionWidgetState extends State<GPTQuestionWidget> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  Future<String> _fetchGPTResponse(String userInput) async {
    final String? apiKey = dotenv.env['OPENAI_API_KEY'];
    const String apiUrl = 'https://api.openai.com/v1/chat/completions';

    if (apiKey == null || apiKey.isEmpty) {
      return 'API 키를 찾을 수 없습니다. .env 파일을 확인하세요.';
    }

    final String systemPrompt = '''
당신은 밀리터리 빈티지 의류에 대한 간결하고 흥미로운 정보를 제공하는 챗봇입니다. 
제품 이름: ${widget.productName}
''';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": systemPrompt},
            {"role": "user", "content": userInput}
          ],
          "max_tokens": 300,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'] ?? '응답이 비어 있습니다.';
      } else {
        return '에러 발생: ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      return '요청 중 에러가 발생했습니다: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라왔을 때 화면 자동 조정
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "질문할 제품: ${widget.productName}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: '제품에 대해 궁금한 점을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50, // 버튼 크기를 고정
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null // 로딩 중이면 비활성화
                      : () async {
                          final userInput = _textController.text;

                          if (userInput.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('질문 내용을 입력하세요!')),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          final response = await _fetchGPTResponse(userInput);

                          setState(() => _isLoading = false);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('GPT의 답변'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        response,
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        speed: const Duration(milliseconds: 50),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('GPT에게 질문하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
