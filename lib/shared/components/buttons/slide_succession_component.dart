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

  // Velocity threshold (px/s) — a fast flick confirms even below 75%.
  static const double _flickVelocity = 800.0;

  double _trackWidth = 0;
  double _thumbOffset = 0;

  double get _maxOffset => (_trackWidth - _thumbSize - _thumbPadding * 2).clamp(0.0, double.infinity);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Unbounded controller — spring simulation drives the value directly.
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

    final bool shouldConfirm = progress >= _confirmFraction || velocity >= _flickVelocity;

    final double target = shouldConfirm ? _maxOffset : 0.0;
    _springTo(target, velocity: velocity);
  }

  void _springTo(double target, {double velocity = 0.0}) {
    // Spring: stiffness controls snappiness, damping controls bounciness.
    final spring = SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 300.0,
      ratio: 0.7, // < 1.0 = under-damped = bouncy
    );

    final simulation = SpringSimulation(spring, _thumbOffset, target, velocity);
    _controller.animateWith(simulation);
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
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
                      child: const Center(child: Icon(Icons.chevron_right, color: Colors.white, size: 30)),
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
