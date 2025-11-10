import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class RegistrationFormSubmitButton extends StatefulWidget {
  final bool isEnabled;
  const RegistrationFormSubmitButton({super.key, required this.isEnabled});

  @override
  State<RegistrationFormSubmitButton> createState() => _RegistrationFormSubmitButtonState();
}

class _RegistrationFormSubmitButtonState extends State<RegistrationFormSubmitButton> {

  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      cursor: widget.isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Opacity(
        opacity: widget.isEnabled ? 1 : 0.25,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Text(
              "Submit",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}