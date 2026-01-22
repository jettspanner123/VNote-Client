import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void _tapDownAction(TapDownDetails _) {
    if (_isClicked) return;
    setState(() {
      _isClicked = true;
    });
    HapticFeedback.lightImpact();
  }

  void _tapCancelAction() {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  void _tapUpAction(TapUpDetails _) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDownAction,
      onTapUp: _tapUpAction,
      onTapCancel: _tapCancelAction,
      onTap: () {
        widget.onTap?.call();
      },
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
    );
  }
}
