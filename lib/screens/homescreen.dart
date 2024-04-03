import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voguegen/colors.dart';
import 'package:voguegen/screens/pexels_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController promptController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final PexelsService pexelsService =
      PexelsService(); // Pexels service instance

  XFile? _image;
  List<String> _imageUrls = []; // List to store fetched image URLs

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _generateStyles() {
    final query = promptController.text;
    if (query.isNotEmpty) {
      pexelsService.searchImages(query).then((imageUrls) {
        setState(() {
          _imageUrls = imageUrls;
        });
      }).catchError((error) {
        print("Error fetching images: $error");
        // Handle or display the error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkPurple, AppColors.lightPurple],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "VogueGen.ai",
                    textStyle: GoogleFonts.poppins(
                      color: AppColors.lightPurple,
                      fontSize: 65.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: Durations.short4,
                  ),
                ],
                repeatForever: true,
              ),
              const SizedBox(height: 40),
              Text(
                "Style Innovation, One Prompt at a Time",
                style: GoogleFonts.poppins(
                  color: AppColors.darkPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, bottom: 25, top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe the style you want to generate',
                  ),
                  keyboardType: TextInputType.text,
                  controller: promptController,
                ),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.black),
                  foregroundColor:
                      WidgetStateProperty.all(AppColors.lightPurple),
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                  textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: AppColors.purple2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _generateStyles,
                child: Text('Generate Styles'),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.lightPurple),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                  textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: AppColors.purple2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'INPUT IMAGE',
                        style: GoogleFonts.poppins(
                          color: AppColors.lightPurple,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (_image != null) ...[
                        Container(
                          width: 400, // Specify the width of the container
                          height: 400, // Specify the height of the container
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit
                                  .cover, // Cover the container potentially cropping the image
                              image: NetworkImage(_image!
                                  .path), // Use the image URL from the picker
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                      if (_image == null) ...[
                        Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black)),
                          child: Center(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Please upload an image',
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 25,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'GENERATED IMAGE',
                        style: GoogleFonts.poppins(
                          color: AppColors.lightPurple,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (_imageUrls.isNotEmpty) ...[
                        Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_imageUrls.first),
                            ),
                          ),
                        ),
                      ],
                      if (_imageUrls.isEmpty) ...[
                        Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black)),
                          child: Center(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Fashion Idea -> VogueGEN ',
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 25,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                                TypewriterAnimatedText(
                                  'Input -> AI -> Output',
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 25,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                      ],
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
