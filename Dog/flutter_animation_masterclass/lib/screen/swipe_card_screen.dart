import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_masterclass/screen/card.dart';

class SwipeCardScreen extends StatefulWidget {
  const SwipeCardScreen({super.key});

  @override
  State<SwipeCardScreen> createState() => _SwipeCardScreenState();
}

class _SwipeCardScreenState extends State<SwipeCardScreen>
    with SingleTickerProviderStateMixin {
  late final Size size = MediaQuery.of(context).size;
  int index = 1;
  //upperbound와 lowerbound를 작성하지 않으면 0~1로 정의된다. 설정한 상한값 하한값을 넘어갈 수 없다.
  late final _position = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      upperBound: size.width + 100,
      lowerBound: -size.width - 100,
      value: 0.0);

  //각도 조절
  late final Tween<double> _rotation = Tween(begin: -15, end: 15);
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1.0);
  late final ColorTween _color =
      ColorTween(begin: Colors.grey, end: Colors.green);
  late final ColorTween _redColor =
      ColorTween(begin: Colors.grey, end: Colors.red);
  void _onHorizontalDrag(DragUpdateDetails detail) {
    setState(
      () {
        _position.value += detail.delta.dx;
      },
    );
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    setState(() {
      if (_position.value.abs() >= size.width - 200) {
        if (_position.value < 0)
          _position.animateTo(-size.width - 100).whenComplete(() {
            _position.value = 0;
            index = index == 4 ? 1 : index + 1;
          });
        else {
          _position.animateTo(size.width + 100).whenComplete(() {
            _position.value = 0;
            index = index == 4 ? 1 : index + 1;
          });
        }
      } else {
        //_position.value = 0; <= 바로 0으로 이동함
        _position.animateTo(0, curve: Curves.bounceOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Card"),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (a, b) {
          //값이 보정되어 들어간다
          //_rotation 의 범위는 -15~15 이 값이 -250~250 사이의 값
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          final scale = _scale.transform((_position.value.abs() / size.width));
          final greenTween = _color.transform(_position.value / size.width > 0
              ? _position.value / size.width
              : 0);
          final redTween = _redColor.transform(
              _position.value < 0 ? _position.value.abs() / size.width : 0);
          return Column(children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: Stack(children: [
                Positioned(
                  top: 50,
                  left: size.width * 0.12,
                  child: Align(
                    child: Transform.scale(
                      scale: min(scale, 1.0),
                      child:
                          CardImage(cardIndex: index + 1 > 4 ? 1 : index + 1),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: size.width * 0.12,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onHorizontalDragUpdate: _onHorizontalDrag,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      child: Transform.rotate(
                        angle: angle * pi / 180,
                        child: Transform.translate(
                          offset: Offset(_position.value, 0),
                          child: CardImage(cardIndex: index),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.scale(
                    scale: 3.0,
                    child: IconButton(
                        onPressed: () {
                          _position
                              .animateTo(-size.width - 100)
                              .whenComplete(() {
                            _position.value = 0;
                            index = index == 4 ? 1 : index + 1;
                          });
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: redTween,
                        ))),
                Transform.scale(
                    scale: 3.0,
                    child: IconButton(
                        onPressed: () {
                          _position
                              .animateTo(size.width + 100)
                              .whenComplete(() {
                            _position.value = 0;
                            index = index == 4 ? 1 : index + 1;
                          });
                        },
                        icon: Icon(
                          Icons.play_circle_fill,
                          color: greenTween,
                        )))
              ],
            )
          ]);
        },
      ),
    );
  }
}
