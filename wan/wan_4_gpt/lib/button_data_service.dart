import 'dart:convert';
import 'package:flutter/services.dart';
import 'button_data_model.dart';

class ButtonDataService {
  // JSON 파일 읽기
  static Future<List<ButtonData>> loadButtonData() async {
    final String jsonString =
        await rootBundle.loadString('Assets/datas/button_data.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => ButtonData.fromJson(data)).toList();
  }
}
