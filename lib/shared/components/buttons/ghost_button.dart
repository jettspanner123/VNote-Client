import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GhostButtonComponent extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool? isLoading;
  final double borderRadius;
  final int animationDuration;
  final Color? backgroundColor;

  const GhostButtonComponent({
    super.key,
    required this.child,
    this.onTap,
    this.isLoading,
    this.borderRadius = 100,
    this.animationDuration = 25,
    this.backgroundColor,
  });

  @override
  State<GhostButtonComponent> createState() => _GhostButtonComponentState();
}

class _GhostButtonComponentState extends State<GhostButtonComponent> {
  bool _isClicked = false;
  void _tapDownAction(_) {
    if (_isClicked) return;
    setState(() {
      _isClicked = true;
    });
    HapticFeedback.lightImpact();
  }

  void _tapCancelAction(_) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  void _tapUpAction(_) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _tapDownAction,
      onPointerUp: _tapUpAction,
      onPointerCancel: _tapCancelAction,
      child: GestureDetector(
        onTap: () {
          widget.onTap?.call();
        },
        child: AnimatedScale(
          scale: _isClicked ? 0.95 : 1.0,
          duration: Duration(milliseconds: widget.animationDuration),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedContainer(
                duration: Duration(milliseconds: widget.animationDuration),
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.backgroundColor ?? Colors.black.withAlpha(15),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
