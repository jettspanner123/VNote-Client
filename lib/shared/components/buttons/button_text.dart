import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:vnote_client/constants/component_constants.dart";

class StandardButtonText extends StatelessWidget {
  final String text;
  final Color foregroundColor;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double fontSize;

  const StandardButtonText({
    super.key,
    required this.text,
    this.foregroundColor = Colors.white,
    this.textAlign = TextAlign.center,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.textStyle,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        style:
            textStyle ??
            GoogleFonts.funnelDisplay(fontSize: fontSize, fontWeight: FontWeight.w600).copyWith(color: foregroundColor),
      ),
    );
  }
}
