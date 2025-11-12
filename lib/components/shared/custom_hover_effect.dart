import "package:flutter/material.dart";
import "package:flutter/services.dart";

class CustomHoverEffect extends StatefulWidget {
  final Widget Function(bool isHovering) builder;
  final SystemMouseCursor cursorType;

  const CustomHoverEffect({
    super.key,
    required this.builder,
    this.cursorType = SystemMouseCursors.basic,
  });

  @override
  State<CustomHoverEffect> createState() => _CustomHoverEffectState();
}

class _CustomHoverEffectState extends State<CustomHoverEffect> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursorType,
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
      child: widget.builder(_isHovering),
    );
  }
}
