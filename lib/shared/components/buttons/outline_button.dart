import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OutlineButtonComponent extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool? isLoading;
  final double borderRadius;
  final int animationDuration;
  final BoxBorder? border;
  final Color backgroundColor;

  const OutlineButtonComponent({
    super.key,
    required this.child,
    this.onTap,
    this.isLoading,
    this.borderRadius = 100,
    this.animationDuration = 25,
    this.border,
    this.backgroundColor = Colors.transparent,
  });

  @override
  State<OutlineButtonComponent> createState() => _OutlineButtonComponentState();
}

class _OutlineButtonComponentState extends State<OutlineButtonComponent> {
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
        child: AnimatedSize(
          duration: 500.milliseconds,
          child: AnimatedScale(
            scale: _isClicked ? 0.95 : 1.0,
            duration: Duration(milliseconds: widget.animationDuration),
            child: AnimatedContainer(
              duration: Duration(milliseconds: widget.animationDuration),
              decoration: BoxDecoration(
                border: widget.border ?? BoxBorder.all(color: Colors.black, width: 0.3),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
