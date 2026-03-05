import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnTapScaleInteractionValue {
  final double initialScale;
  final double finalScale;
  final Duration? duration;
  final bool wantHaptics;

  OnTapScaleInteractionValue({
    required this.initialScale,
    required this.finalScale,
    this.duration,
    this.wantHaptics = true,
  });

  static OnTapScaleInteractionValue normalInteraction() {
    return OnTapScaleInteractionValue(initialScale: 1, finalScale: 1.1);
  }
}

class OnTapScaleInteractionComponent extends StatefulWidget {
  final Widget child;
  final OnTapScaleInteractionValue config;
  VoidCallback? onTap;
  OnTapScaleInteractionComponent({super.key, required this.child, required this.config, this.onTap});

  @override
  State<OnTapScaleInteractionComponent> createState() => _OnTapScaleInteractionComponentState();
}

class _OnTapScaleInteractionComponentState extends State<OnTapScaleInteractionComponent> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        if (_isTapped) return;
        setState(() {
          _isTapped = true;
        });
        HapticFeedback.lightImpact();
      },
      onPointerUp: (_) {
        if (!_isTapped) return;
        setState(() {
          _isTapped = false;
        });
        widget.onTap?.call();
      },
      onPointerCancel: (_) {
        if (!_isTapped) return;
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? widget.config.initialScale : widget.config.finalScale,
        duration: widget.config.duration ?? const Duration(milliseconds: 50),
        child: widget.child,
      ),
    );
  }
}
