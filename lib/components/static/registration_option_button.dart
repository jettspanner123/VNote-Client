import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class RegistrationOptionButton extends StatefulWidget {
  final IconData icon;
  final String name;

  const RegistrationOptionButton({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  State<RegistrationOptionButton> createState() =>
      _RegistrationOptionButtonState();
}

class _RegistrationOptionButtonState extends State<RegistrationOptionButton> {
  bool _isHovering = false;

  Color _getHoverBackgroundColor() {
    return _isHovering ? Colors.black : Colors.white;
  }

  Color _getHoverForegroundColor() {
    return _isHovering ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: _getHoverBackgroundColor(),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Icon(widget.icon, size: 20, color: _getHoverForegroundColor()),
                Text(
                  widget.name,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: _getHoverForegroundColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}