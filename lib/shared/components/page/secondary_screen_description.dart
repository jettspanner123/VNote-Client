import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryScreenDescriptionComponent extends StatelessWidget {
  final String text;
  const SecondaryScreenDescriptionComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: GoogleFonts.funnelSans(fontSize: 15, color: Colors.black.withAlpha(120))),
        ),
      ],
    );
  }
}
