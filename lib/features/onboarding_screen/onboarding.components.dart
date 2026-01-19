import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageView extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const OnboardingPageView({super.key, required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 70),

          // Image
          Image.asset(image, height: 300),

          // Title
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.funnelSans(fontSize: 27, fontWeight: FontWeight.bold, height: 1),
            ),
          ),

          SizedBox(height: 20),

          // Description
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.funnelSans(fontSize: 16, fontWeight: FontWeight.w200),
            ),
          ),
        ],
      ),
    );
  }
}
