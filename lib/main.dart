import 'package:flutter/material.dart';
import 'package:voguegen/screens/homescreen.dart';
import 'package:voguegen/screens/splash_screen.dart'; // Adjust the import based on your file structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VogueGEN.ai',
      home: SplashScreen(),
    );
  }
}
