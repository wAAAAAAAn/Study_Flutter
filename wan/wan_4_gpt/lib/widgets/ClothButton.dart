import 'package:flutter/material.dart';

class HighlightedImageButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const HighlightedImageButton({
    super.key,
    required this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue.withOpacity(0.5) // 선택된 버튼 배경색
                  : Colors.grey.withOpacity(0.1), // 기본 배경색
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey, // 선택 상태에 따른 테두리
                width: 2,
              ),
            ),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black, // 선택된 타이틀 색
            ),
          ),
        ],
      ),
    );
  }
}
