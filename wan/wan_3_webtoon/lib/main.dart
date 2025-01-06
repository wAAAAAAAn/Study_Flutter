import 'package:flutter/material.dart';
import 'package:wan_3_webtoon/Screens/home_scressn.dart';
import 'package:wan_3_webtoon/services/ApiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
