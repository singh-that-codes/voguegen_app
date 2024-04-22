import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voguegen/colors.dart';
import 'package:voguegen/screens/homescreen.dart'; // Ensure this imports your AppColors

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Adjust the time for your needs
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomeScreen()), // Navigate to your main screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkPurple, AppColors.lightPurple],
          ),
        ),
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                "VogueGen.ai",
                textStyle: GoogleFonts.poppins(
                  color: AppColors.lightPurple,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(
                  milliseconds: 200,
                ), // Durations.short4 may need to be defined or replaced
              ),
            ],
            //repeatForever: true,
          ),
        ),
      ),
    );
  }
}
