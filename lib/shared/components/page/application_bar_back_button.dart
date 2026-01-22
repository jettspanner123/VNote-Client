import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationBarBackButtonComponent extends StatefulWidget {
  final VoidCallback? onTap;
  const ApplicationBarBackButtonComponent({super.key, this.onTap});

  @override
  State<ApplicationBarBackButtonComponent> createState() => ApplicationBarBackButtonComponentState();
}

class ApplicationBarBackButtonComponentState extends State<ApplicationBarBackButtonComponent> {
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

  void _handleTapCancel() {
    if (isTapped) {
      setState(() {
        isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.onTap ??
          () {
            Navigator.of(context).pop();
          },
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
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
          child: Icon(Icons.chevron_left),
        ),
      ),
    );
  }
}
