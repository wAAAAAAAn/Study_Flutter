import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMin = 1500;

  int totalSeconds = twentyFiveMin;
  int totalPomodorous = 0;
  late Timer timer;

  String format(int second) {
    var duration = Duration(seconds: second);
    return duration.toString().split(".").first.substring(2, 7);
  }

  bool isRunning = false;

  void onTick(Timer timer) {
    setState(() {
      if (totalSeconds == 0) {
        totalPomodorous += 1;
        totalSeconds = twentyFiveMin;
        timer.cancel();
        isRunning = false;
      } else {
        totalSeconds -= 1;
      }
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onReset() {
    setState(() {
      timer.cancel();
      isRunning = false;
      totalSeconds = twentyFiveMin;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
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
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color ??
                        Colors.red,
                    fontSize:
                        Theme.of(context).textTheme.displayLarge?.fontSize ??
                            89,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: Icon((!isRunning
                          ? Icons.play_circle_outline
                          : Icons.pause_circle_filled_outlined)),
                      onPressed: !isRunning ? onStartPressed : onPausePressed,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: onReset,
                        child: Text(
                          'RESET',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ],
                ),
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
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodors',
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('$totalPomodorous',
                            style: TextStyle(
                                fontSize: 68,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontWeight: FontWeight.w600)),
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
