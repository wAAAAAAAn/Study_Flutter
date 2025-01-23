import 'package:wan_animation/screens/AppleWatchScreen.dart';
import 'package:wan_animation/screens/ExplicitAnimationscreen.dart';
import 'package:wan_animation/screens/ImplicitAnimationScreens.dart';
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
                  navigatorScreen(context, const Implicitanimationscreens());
                },
                child: const Text("Implicitanimationscreens")),
            ElevatedButton(
                onPressed: () {
                  navigatorScreen(context, const ExplicitAnimationScreen());
                },
                child: const Text("ExplicitAnimationScreen")),
            ElevatedButton(
                onPressed: () {
                  navigatorScreen(context, const Applewatchscreen());
                },
                child: const Text("Applewatchscreen"))
          ],
        ),
      ),
    );
  }

  void navigatorScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
