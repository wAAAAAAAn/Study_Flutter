import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GPTQuestionWidget extends StatefulWidget {
  final String productName; // 제품 이름

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

  // GPT API 호출 함수
  Future<String> _fetchGPTResponse(String userInput) async {
    final String? apiKey = dotenv.env['OPENAI_API_KEY']; // .env에서 API 키 가져오기
    const String apiUrl = 'https://api.openai.com/v1/chat/completions';

    if (apiKey == null || apiKey.isEmpty) {
      return 'API 키를 찾을 수 없습니다. .env 파일을 확인하세요.';
    }

    final String systemPrompt =
        "당신은 빈티지 밀리터리 의류 전문가입니다. 주로 빈티지 샵에서 판매하는 의류들을 취급하며 빈티지 의류의 역사와 어떤 군대에서 사용했는지 장점은 무엇인지를 설명을 합니다. \n 아래의 제품 이름과 관련된 질문에 대해 간단하고 명확하며 흥미를 가질만한 의견을 덧붙여 답변을 중간 중간 이모티콘을 붙여서 귀여운 느낌이 나게 제공합니다.\n"
        "제품 이름: ${widget.productName}\n";

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
            {"role": "system", "content": systemPrompt}, // 시스템 프롬프트
            {"role": "user", "content": userInput} // 사용자 질문
          ],
          "max_tokens": 150,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩
        final String result = data['choices'][0]['message']['content'];
        return result;
      } else {
        debugPrint('Error: ${response.statusCode}');
        return '에러 발생: ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      debugPrint('Error: $e');
      return '요청 중 에러가 발생했습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: '제품에 대해 궁금한 점을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final userInput = _textController.text;

            if (userInput.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('질문 내용을 입력하세요!')),
              );
              return;
            }

            setState(() {
              _isLoading = true; // 로딩 시작
            });

            // API 호출 및 결과 가져오기
            final response = await _fetchGPTResponse(userInput);

            setState(() {
              _isLoading = false; // 로딩 종료
            });

            // 결과값 다이얼로그 표시
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('GPT의 답변'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false, // 애니메이션 반복 여부
                      animatedTexts: [
                        TyperAnimatedText(
                          response, // GPT의 응답 텍스트
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          speed: const Duration(milliseconds: 50), // 타이핑 속도
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
      ],
    );
  }
}
