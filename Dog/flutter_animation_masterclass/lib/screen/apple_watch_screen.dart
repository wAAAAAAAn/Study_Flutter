import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3000),
  );
  // code Challenge 1 ->
  final endValue = Random().nextDouble() * 2.0;
  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
  late Animation<double> _progress_red =
      Tween(begin: 0.005, end: endValue).animate(_curve);
  late Animation<double> _progress_green =
      Tween(begin: 0.005, end: endValue).animate(_curve);
  late Animation<double> _progress_blue =
      Tween(begin: 0.005, end: endValue).animate(_curve);
  void _animateValue() {
    final redBegin = _progress_red.value;
    final blueBegin = _progress_blue.value;
    final greenBegin = _progress_green.value;
    final random = Random();
    final redTween =
        Tween(begin: redBegin, end: random.nextDouble() * 2.0).animate(_curve);
    final blueTween =
        Tween(begin: blueBegin, end: random.nextDouble() * 2.0).animate(_curve);
    final greenTween = Tween(begin: greenBegin, end: random.nextDouble() * 2.0)
        .animate(_curve);
    setState(() {
      _progress_red = redTween;
      _progress_blue = blueTween;
      _progress_green = greenTween;
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Apple Watch',
          style: TextStyle(color: Colors.white, backgroundColor: Colors.black),
        ),
        backgroundColor: Colors.black,
      ),
      //CustomPainter는 CustomPaint 안에서 정의 되어야 한다.
      //CustomPainter가 그려질 공간을 정의하는 곳이다.
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => CustomPaint(
            painter: AppleWatchPainter(
              progress_red: _progress_red.value,
              progress_blue: _progress_blue.value,
              progress_green: _progress_green.value,
            ),
            size: const Size(400, 400),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => {_animateValue()},
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  late double progress_red;
  late double progress_blue;
  late double progress_green;

  AppleWatchPainter(
      {required this.progress_red,
      required this.progress_blue,
      required this.progress_green});
  @override
  //이걸로 그림을 그린다.
  void paint(Canvas canvas, Size size) {
    //어떤 형태로 그릴지 정의
    //final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    //어떤 형태를 어떻게 그릴지 정의
    //final Paint paint = Paint()..color = Colors.blue;
    //canvas로 그림을 그린다.
    //canvas.drawRect(rect, paint);
    Offset center = Offset(size.width / 2, size.width / 2);
    canvas.drawCircle(
        center,
        size.width * 0.9 / 2,
        Paint()
          ..color = Colors.red.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20);
    canvas.drawCircle(
        center,
        size.width * 0.76 / 2,
        Paint()
          ..color = Colors.green.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20);
    canvas.drawCircle(
        center,
        size.width * 0.62 / 2,
        Paint()
          ..color = Colors.blue.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20);
    final redArcRect =
        Rect.fromCircle(center: center, radius: size.width * 0.9 / 2);
    final redArcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    final greenArcRect = Rect.fromCircle(
      center: center,
      radius: size.width * 0.76 / 2,
    );
    final greenArcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    final blueArcRect =
        Rect.fromCircle(center: center, radius: size.width * 0.62 / 2);
    final blueArcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    double startAngle = -0.5 * pi;
    double redEnd = progress_red * pi;
    double greenEnd = progress_green * pi;
    double blueEnd = progress_blue * pi;
    canvas.drawArc(redArcRect, startAngle, redEnd, false, redArcPaint);
    canvas.drawArc(greenArcRect, startAngle, greenEnd, false, greenArcPaint);
    canvas.drawArc(blueArcRect, startAngle, blueEnd, false, blueArcPaint);
  }

  @override
  //과거 데이터(페인터)를 받아서 값을 비교하여 refresh 할 것인가 안 할 것인가를 확인하는것
  //프레임 단위로 계속 렌더링을 할건지 안할 것인지 정한다.
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress_blue != progress_blue &&
        oldDelegate.progress_green != progress_green &&
        oldDelegate.progress_red != progress_red;
  }
}
