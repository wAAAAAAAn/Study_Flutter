import 'dart:math';

import 'package:flutter/material.dart';

class RadarAnimation extends StatefulWidget {
  const RadarAnimation({super.key});

  @override
  _RadarAnimationState createState() => _RadarAnimationState();
}

class _RadarAnimationState extends State<RadarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double radius;
  late List<String> strinArr = [];
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    radius = min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) /
        1.1;
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            child: GestureDetector(
              onTap: () => {setState(() => strinArr.add("test"))},
              child: Center(
                child: RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: radius,
                    height: radius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          const Color.fromARGB(255, 89, 163, 80),
                          const Color.fromARGB(255, 45, 99, 38),
                          const Color.fromARGB(255, 89, 163, 80),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (String target in strinArr) Text(target),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
