import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SlideSuccessionComponent extends StatefulWidget {
  const SlideSuccessionComponent({super.key});

  @override
  State<SlideSuccessionComponent> createState() => _SlideSuccessionComponentState();
}

class _SlideSuccessionComponentState extends State<SlideSuccessionComponent> with SingleTickerProviderStateMixin {
  static const double _height = 75.0;
  static const double _thumbSize = 65.0;
  static const double _thumbPadding = 5.0;
  static const double _confirmFraction = 0.75;
  static const double _flickVelocity = 800.0;

  double _trackWidth = 0;
  double _thumbOffset = 0;

  double get _maxOffset => (_trackWidth - _thumbSize - _thumbPadding * 2).clamp(0.0, double.infinity);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
    _controller.addListener(() {
      setState(() {
        _thumbOffset = _controller.value.clamp(0.0, _maxOffset);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── drag ────────────────────────────────────────────────────────────────

  void _onDragUpdate(DragUpdateDetails details) {
    _controller.stop();
    setState(() {
      _thumbOffset = (_thumbOffset + details.delta.dx).clamp(0.0, _maxOffset);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    final progress = _maxOffset > 0 ? _thumbOffset / _maxOffset : 0.0;
    final shouldConfirm = progress >= _confirmFraction || velocity >= _flickVelocity;
    _springTo(shouldConfirm ? _maxOffset : 0.0, velocity: velocity);
  }

  void _springTo(double target, {double velocity = 0.0}) {
    final spring = SpringDescription.withDampingRatio(mass: 1.0, stiffness: 300.0, ratio: 0.7);
    _controller.animateWith(SpringSimulation(spring, _thumbOffset, target, velocity));
  }

  // ── icon blend ──────────────────────────────────────────────────────────

  Widget _buildThumbIcon(double progress) {
    final chevronOpacity = (1.0 - progress * 2).clamp(0.0, 1.0);
    final checkOpacity = ((progress - 0.5) * 2).clamp(0.0, 1.0);
    final chevronAngle = math.pi / 2 * progress;
    final checkAngle = -math.pi / 2 * (1.0 - progress);
    final blurAmount = math.sin(progress * math.pi) * 6.0;

    Widget blurred(Widget child, double blur) {
      if (blur < 0.1) return child;
      return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Chevron — rotates and fades out
        Opacity(
          opacity: chevronOpacity,
          child: blurred(
            Transform.rotate(
              angle: chevronAngle,
              child: const Icon(Icons.chevron_right, color: Colors.white, size: 30),
            ),
            blurAmount * chevronOpacity,
          ),
        ),
        // Checkmark — rotates and fades in
        Opacity(
          opacity: checkOpacity,
          child: blurred(
            Transform.rotate(
              angle: checkAngle,
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
            ),
            blurAmount * checkOpacity,
          ),
        ),
      ],
    );
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final progress = _maxOffset > 0 ? (_thumbOffset / _maxOffset).clamp(0.0, 1.0) : 0.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_trackWidth != constraints.maxWidth) {
            setState(() => _trackWidth = constraints.maxWidth);
          }
        });

        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withAlpha(30), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _thumbPadding),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Label
                ColorModeAwareTextComponent(
                  text: "Slide To Confirm",
                  lightColor: Colors.black.withAlpha(50),
                  darkColor: Colors.white.withAlpha(50),
                  style: UIHelper.current.funnelTextStyle(fontWeight: FontWeight.w500),
                ),

                // Slidable thumb
                Positioned(
                  left: _thumbOffset,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    child: Container(
                      height: _thumbSize,
                      width: _thumbSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorFactory.accentColor,
                        border: Border.all(color: Colors.white.withAlpha(20), width: 1),
                      ),
                      child: Center(child: _buildThumbIcon(progress)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
