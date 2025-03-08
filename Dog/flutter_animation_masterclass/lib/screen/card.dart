import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final int cardIndex;

  const CardImage({super.key, required this.cardIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 300,
          height: 500,
          child: Image.asset(
            'assets/covers/$cardIndex.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
