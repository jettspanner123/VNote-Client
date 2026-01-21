import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryScreenHeadingComponent extends StatelessWidget {
  final String text;
  const SecondaryScreenHeadingComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: GoogleFonts.funnelSans(fontSize: 30, fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }
}
