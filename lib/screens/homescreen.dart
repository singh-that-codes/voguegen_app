import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voguegen/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController promptController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(
        () {
          _image = pickedFile;
        },
      );
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkPurple,
              AppColors.lightPurple,
            ], // Specify gradient colors here
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText("VogueGen.ai",
                      textStyle: GoogleFonts.poppins(
                        color: AppColors.lightPurple,
                        fontSize: 65.0,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: Durations.long1),
                ],
                repeatForever: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Style Innovation, One Prompt at a Time",
                style: GoogleFonts.poppins(
                  color: AppColors.purple2,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 25,
                  top: 10,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Enter your style prompt',
                    hintText: 'Describe the style you want to generate',
                  ),
                  keyboardType: TextInputType.text,
                  // Optional: Add a controller to retrieve the input text
                ),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.black,
                  ),
                  foregroundColor:
                      WidgetStateProperty.all(AppColors.lightPurple),
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                  textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: AppColors.purple2),
                    ),
                  ),
                ),
              ),
              if (_image != null) ...[
                Image.file(
                  File(
                    _image!.path,
                  ),
                ), // Display the selected image
                SizedBox(
                  height: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
