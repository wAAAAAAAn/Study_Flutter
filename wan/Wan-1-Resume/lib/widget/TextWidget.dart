import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String infoText;
  final IconData icon;

  const IconText({super.key, required this.infoText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          infoText,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        )
      ],
    );
  }
}
