import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Timer
  static const MaxTimer = 1500;
  int totalSeconds = MaxTimer;
  late Timer timer;
  bool isRun = false;
  int totalPomodoros = 0;

  void onPressedTimer() {
    print("Start");

    timer = Timer.periodic(const Duration(seconds: 1), timerCallback);
    isRun = true;
    setState(() {});
  }

  void onPressedPause() {
    print("pause");

    timer.cancel();
    setState(() {
      isRun = false;
    });
  }

  void onPressRestart() {
    timer.cancel();

    totalSeconds = MaxTimer;
    onPressedTimer();
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (totalSeconds == 0) {
        totalPomodoros = totalPomodoros + 1;
        totalSeconds = MaxTimer;
        isRun = false;
        timer.cancel();
      } else {
        totalSeconds = totalSeconds - 1;
      }
    });
  }

  String convertDateTime(int seconds) {
    var duration = Duration(seconds: seconds);
    var durationText = duration.toString().split('.').first.substring(2);
    return durationText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  convertDateTime(totalSeconds),
                  style: TextStyle(
                      fontSize: 89,
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w600),
                ),
              )),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  isRun
                      ? const GifReplacementExample()
                      : const SizedBox(
                          height: 0,
                        ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: isRun ? onPressedPause : onPressedTimer,
                        icon: isRun
                            ? const Icon(Icons.pause_circle_outline)
                            : const Icon(Icons.play_circle_outline),
                        iconSize: 70,
                        color: Theme.of(context).cardColor,
                      ),
                      isRun
                          ? IconButton(
                              onPressed: onPressRestart,
                              icon: const Icon(Icons.restart_alt_outlined),
                              iconSize: 70,
                              color: Theme.of(context).cardColor,
                            )
                          : const SizedBox(
                              height: 0,
                            )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Pomodoros",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: const TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GifReplacementExample extends StatelessWidget {
  const GifReplacementExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8, // 너비 제한 (화면의 80%)
      height: MediaQuery.of(context).size.height * 0.4, // 높이 제한 (화면의 40%)
      child: Image.asset(
        "assets/oiia-oiiaoiia.gif",
        fit: BoxFit.contain, // 이미지 비율 유지
      ).animate().fadeIn(),
    );
  }
}
