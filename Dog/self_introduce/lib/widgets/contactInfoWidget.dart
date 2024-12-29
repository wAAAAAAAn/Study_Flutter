import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget contactInfoWidget(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(children: [
      DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        dashPattern: [6, 6], // 점선의 길이와 간격
        color: Colors.black,
        padding: EdgeInsets.zero, // 안쪽 여백 없음
        child: Container(
          height: 1, // 점선 높이 설정
        ),
      ),
      Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
      DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        dashPattern: [6, 6], // 점선의 길이와 간격
        color: Colors.black,
        padding: EdgeInsets.zero, // 안쪽 여백 없음
        child: Container(
          height: 1, // 점선 높이 설정
        ),
      ),
    ]),
  );
}
