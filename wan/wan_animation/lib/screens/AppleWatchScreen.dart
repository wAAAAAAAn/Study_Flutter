import 'dart:math';

import 'package:flutter/material.dart';

class Applewatchscreen extends StatefulWidget {
  const Applewatchscreen({super.key});

  @override
  State<Applewatchscreen> createState() => _ApplewatchscreenState();
}

class _ApplewatchscreenState extends State<Applewatchscreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final CurvedAnimation _curveTween = CurvedAnimation(
    curve: Curves.bounceIn,
    parent: _animationController,
  );

  late Animation<double> _tween =
      Tween(begin: 0.005, end: 1.5).animate(_curveTween);

  void onclickAnimation() {
    final newBegin = _tween.value;

    final Random rand = Random();
    final newEnd = rand.nextDouble() * 2.0;

    setState(() {
      _tween = Tween(begin: newBegin, end: newEnd).animate(_curveTween);
    });
    _animationController.forward(from: 0);
  }

  void onclickReturn() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apple Watch"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedBuilder(
                animation: _tween,
                builder: (context, child) {
                  return CustomPaint(
                    painter: AppleWatchCanvas(progress: _tween.value),
                    size: const Size(400, 400),
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    onclickAnimation();
                  },
                  child: const Icon(Icons.refresh_outlined),
                ),
                FloatingActionButton(
                  onPressed: () {
                    onclickReturn();
                  },
                  child: const Icon(Icons.keyboard_return),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppleWatchCanvas extends CustomPainter {
  var progress = 0.005;

  AppleWatchCanvas({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeSize = 25.0;
    final center = Offset(size.width / 2, size.height / 2);

    var redPaint = Paint()
      ..color = Colors.red.shade500.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize;

    final redRadius = (size.width / 2) * 0.9;

    canvas.drawCircle(center, redRadius, redPaint);

    var redarcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize
      ..strokeCap = StrokeCap.round;

    Rect redardRect = Rect.fromCircle(center: center, radius: redRadius);
    canvas.drawArc(redardRect, 1.5 * pi, progress * pi, false, redarcPaint);

    //-----------------------

    var greenPaint = Paint()
      ..color = Colors.green.shade500.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize;

    final greenRadius = (size.width / 2) * 0.75;

    canvas.drawCircle(center, greenRadius, greenPaint);

    var greenarcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize
      ..strokeCap = StrokeCap.round;

    Rect greenardRect = Rect.fromCircle(center: center, radius: greenRadius);
    canvas.drawArc(greenardRect, 1.5 * pi, progress * pi, false, greenarcPaint);

    //-----------------------

    var bluePaint = Paint()
      ..color = Colors.cyan.shade500.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize;

    final blueRadius = (size.width / 2) * 0.6;

    canvas.drawCircle(center, blueRadius, bluePaint);

    var bluearcPaint = Paint()
      ..color = Colors.cyan.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeSize
      ..strokeCap = StrokeCap.round;

    Rect blueardRect = Rect.fromCircle(center: center, radius: blueRadius);
    canvas.drawArc(blueardRect, 1.5 * pi, progress * pi, false, bluearcPaint);
  }

  @override
  bool shouldRepaint(covariant AppleWatchCanvas oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
