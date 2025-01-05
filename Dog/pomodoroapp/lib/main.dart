import 'package:flutter/material.dart';
import 'package:pomodoroapp/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE7626C),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
            fontSize: 89,
          ),
          bodyMedium: TextStyle(
              color: Color.fromARGB(255, 193, 162, 123), fontSize: 40),
        ),
        cardColor: Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}
