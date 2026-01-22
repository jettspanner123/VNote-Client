import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationBarDismissButtonComponent extends StatefulWidget {
  final VoidCallback? onTap;
  const ApplicationBarDismissButtonComponent({super.key, this.onTap});

  @override
  State<ApplicationBarDismissButtonComponent> createState() => ApplicationBarDismissButtonComponentState();
}

class ApplicationBarDismissButtonComponentState extends State<ApplicationBarDismissButtonComponent> {
  bool isTapped = false;

  void _handleTapDown(_) {
    if (!isTapped) {
      setState(() {
        isTapped = true;
      });
    }
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(_) {
    if (isTapped) {
      setState(() {
        isTapped = false;
      });
    }
  }

  void _handleTapCancel(_) {
    if (isTapped) {
      setState(() {
        isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerCancel: _handleTapCancel,
      onPointerUp: _handleTapUp,
      onPointerDown: _handleTapDown,
      child: GestureDetector(
        onTap:
            widget.onTap ??
            () {
              Navigator.of(context).pop();
            },
        child: AnimatedScale(
          scale: isTapped ? 0.95 : 1,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: BoxBorder.all(color: Colors.black.withAlpha(50)),
              borderRadius: BorderRadiusDirectional.circular(100),
            ),
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
