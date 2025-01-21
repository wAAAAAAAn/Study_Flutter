import 'dart:async';

import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 1))
    ..addListener(() {
      _range.value = _animationController.value;
    });

  late final Animation<Decoration> _decoration = DecorationTween(
          begin: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          end: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(120)))
      .animate(_curvedAnimation);

  late final Animation<double> _ratation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 1.2).animate(_animationController);

  late final Animation<Offset> _offset =
      Tween(begin: Offset.zero, end: const Offset(0, -0.3))
          .animate(_curvedAnimation);

  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCirc,
      reverseCurve: Curves.bounceInOut);

  late final ValueNotifier<double> _range = ValueNotifier(0.0);

  void _onChange(double value) {
    _range.value = 0;
    _animationController.value = value;
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  bool islooping = false;

  void _toggleLooping() {
    if (!islooping) {
      _animationController.stop();
    } else {
      _animationController.repeat(reverse: true);
    }

    setState(() {
      islooping = !islooping;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ExplicitAnimationScreen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _offset,
            child: ScaleTransition(
              scale: _scale,
              child: RotationTransition(
                turns: _ratation,
                child: DecoratedBoxTransition(
                  decoration: _decoration,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.network(
                      "https://static1.e926.net/data/sample/0e/a8/0ea842fd74cb28e6986d791bb4c3a2bd.jpg",
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _play();
                  },
                  child: const Text("Play")),
              ElevatedButton(
                  onPressed: () {
                    _pause();
                  },
                  child: const Text("Pause")),
              ElevatedButton(
                  onPressed: () {
                    _rewind();
                  },
                  child: const Text("Rewind")),
              ElevatedButton(
                  onPressed: () {
                    _toggleLooping();
                  },
                  child: Text(islooping == true ? "looping" : "not")),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ValueListenableBuilder(
              valueListenable: _range,
              builder: (context, value, child) {
                return Slider(value: _range.value, onChanged: _onChange);
              })
        ],
      ),
    );
  }
}
