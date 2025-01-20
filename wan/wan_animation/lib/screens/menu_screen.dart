import 'package:animation/screens/ImplicitAnimationScreens.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animations"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  navigatorScreen(context);
                },
                child: const Text("data"))
          ],
        ),
      ),
    );
  }

  void navigatorScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Implicitanimationscreens(),
      ),
    );
  }
}
