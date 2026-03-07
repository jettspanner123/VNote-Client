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
  final bool? oneTapOnly;
  final VoidCallback? onTap;
  OnTapScaleInteractionComponent({super.key, required this.child, required this.config, this.onTap, this.oneTapOnly});

  @override
  State<OnTapScaleInteractionComponent> createState() => _OnTapScaleInteractionComponentState();
}

class _OnTapScaleInteractionComponentState extends State<OnTapScaleInteractionComponent> {
  bool _isTapped = false;
  int _tapCount = 0;

  bool get _shouldScale {
    if (widget.oneTapOnly != true) return true;
    return _tapCount % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        if (_isTapped) return;

        final shouldScale = _shouldScale;

        setState(() {
          _isTapped = shouldScale;
          _tapCount++;
        });

        if (shouldScale && widget.config.wantHaptics) {
          HapticFeedback.lightImpact();
        }
      },
      onPointerUp: (_) {
        if (!_isTapped) {
          widget.onTap?.call();
          return;
        }
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
