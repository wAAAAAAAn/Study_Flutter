import 'package:flutter/material.dart';
import 'package:restraunt_rader/screen/rader_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("뽑기"),
        backgroundColor: Color.fromARGB(99, 111, 142, 61),
      ),
      body: RadarAnimation(),
    );
  }
}
