import "package:flutter/material.dart";

enum CustomButtons { normal, outline }

class CustomButton extends StatefulWidget {
  final CustomButtons buttonType;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget content;
  final double disableOpacity;
  final Color hoverBackgroundColor;
  final Color hoverForegroundColor;
  final bool isEnabled;

  const CustomButton({
    super.key,
    this.buttonType = CustomButtons.normal,
    required this.onTap,
    required this.backgroundColor,
    required this.content,
    this.disableOpacity = 0.5,
    this.hoverBackgroundColor = Colors.black,
    this.hoverForegroundColor = Colors.white,
    this.isEnabled = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Opacity(
          opacity: !widget.isEnabled ? widget.disableOpacity : 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.backgroundColor,
                width: widget.buttonType == CustomButtons.outline ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(5),
              color: widget.buttonType == CustomButtons.normal
                  ? widget.backgroundColor
                  : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: widget.content,
            ),
          ),
        ),
      ),
    );
  }
}
