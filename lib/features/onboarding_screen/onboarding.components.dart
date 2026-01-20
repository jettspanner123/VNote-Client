import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageView extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  const OnboardingPageView({super.key, required this.title, required this.description, required this.image});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),

          // Image
          Image.asset(widget.image, height: 300),

          // Title
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.funnelSans(fontSize: 28, fontWeight: FontWeight.bold, height: 1),
            ),
          ),

          SizedBox(height: 20),

          // Description
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.funnelSans(fontSize: 19, fontWeight: FontWeight.w100, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
