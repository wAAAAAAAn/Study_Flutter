import 'package:flutter/material.dart';
import 'package:flutter_animation_masterclass/screen/%08explicit_animation_screen.dart';
import 'package:flutter_animation_masterclass/screen/apple_watch_screen.dart';
import 'package:flutter_animation_masterclass/screen/implicit_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animation"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, ImplicitAnimationsScreen()),
              child: const Text('Implicit Animations'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ExplicitAnimationsScreen()),
              child: const Text('Explicit Animations'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, AppleWatchScreen()),
              child: const Text('Apple Watch Project'),
            ),
          ],
        ),
      ),
    );
  }
}
