import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SlideSuccessionComponent extends StatefulWidget {
  /// Called when the thumb is dragged all the way to the right end.
  final VoidCallback? onConfirmed;

  /// Optional key attached to the thumb container so the parent can read
  /// its global position for origin-based animations (e.g. CircularRevealRoute).
  final GlobalKey? thumbKey;

  /// 0.85 = thumb must reach 85% of the track before confirming.
  final double confirmThreshold;

  const SlideSuccessionComponent({super.key, this.onConfirmed, this.thumbKey, this.confirmThreshold = 0.85});

  @override
  State<SlideSuccessionComponent> createState() => _SlideSuccessionComponentState();
}

class _SlideSuccessionComponentState extends State<SlideSuccessionComponent> with SingleTickerProviderStateMixin {
  static const double _trackHeight = 75.0;
  static const double _thumbSize = 65.0;
  static const double _thumbPadding = 5.0;

  // Maximum offset the thumb can travel.
  double get _maxOffset => _trackWidth - _thumbSize - _thumbPadding * 2;

  double _trackWidth = 0;
  double _thumbOffset = 0;
  bool _confirmed = false;

  late final AnimationController _snapController;
  late Animation<double> _snapAnimation;

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  // ── drag handlers ────────────────────────────────────────────────────────

  void _onDragUpdate(DragUpdateDetails details) {
    if (_confirmed) return;
    setState(() {
      _thumbOffset = (_thumbOffset + details.delta.dx).clamp(0.0, _maxOffset);
    });
  }

  void _onDragEnd(DragEndDetails _) {
    if (_confirmed) return;
    final progress = _maxOffset > 0 ? _thumbOffset / _maxOffset : 0.0;

    if (progress >= widget.confirmThreshold) {
      // Snap to end, then fire callback.
      _snapTo(
        _maxOffset,
        onDone: () {
          setState(() => _confirmed = true);
          widget.onConfirmed?.call();
        },
      );
    } else {
      // Spring back to start.
      _snapTo(0);
    }
  }

  void _snapTo(double target, {VoidCallback? onDone}) {
    _snapAnimation =
        Tween<double>(
          begin: _thumbOffset,
          end: target,
        ).animate(CurvedAnimation(parent: _snapController, curve: Curves.easeOutCubic))..addListener(() {
          setState(() => _thumbOffset = _snapAnimation.value);
        });

    _snapController.forward(from: 0).then((_) => onDone?.call());
  }

  // ── icon blend ──────────────────────────────────────────────────────────

  /// Blends between the chevron and checkmark as [progress] goes 0 → 1.
  /// - First half  (0.0 – 0.5): chevron fades + blurs + rotates out
  /// - Second half (0.5 – 1.0): checkmark fades + blurs + rotates in
  Widget _buildThumbIcon(double progress) {
    // Chevron: full opacity at 0, gone by 0.5
    final chevronOpacity = (1.0 - progress * 2).clamp(0.0, 1.0);
    // Checkmark: invisible until 0.5, full opacity at 1.0
    final checkOpacity = ((progress - 0.5) * 2).clamp(0.0, 1.0);

    // Rotation: chevron rotates 0 → -90°, checkmark rotates +90° → 0
    final chevronAngle = math.pi / 2 * progress;
    final checkAngle = -math.pi / 2 * (1.0 - progress);

    // Blur peaks at progress = 0.5 (mid-transition), 0 at both ends
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
        // Chevron — rotates & fades out
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
        // Checkmark — rotates & fades in
        Opacity(
          opacity: checkOpacity,
          child: blurred(
            Transform.rotate(
              angle: checkAngle,
              child: Icon(Icons.check_rounded, color: Colors.white, size: 28),
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
        // Capture the real track width once layout is known.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_trackWidth != constraints.maxWidth) {
            setState(() => _trackWidth = constraints.maxWidth);
          }
        });

        return Container(
          height: _trackHeight,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withAlpha(30), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _thumbPadding),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // ── Label (fades out as thumb advances) ──────────────────
                Opacity(
                  opacity: (1.0 - progress * 2).clamp(0.0, 1.0),
                  child: ColorModeAwareTextComponent(
                    text: "Slide To Confirm",
                    lightColor: Colors.black.withAlpha(50),
                    darkColor: Colors.white.withAlpha(50),
                    style: UIHelper.current.funnelTextStyle(fontWeight: FontWeight.w500),
                  ),
                ),

                // ── Slidable thumb ───────────────────────────────────────
                Positioned(
                  left: _thumbOffset,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    child: AnimatedContainer(
                      key: widget.thumbKey,
                      duration: const Duration(milliseconds: 150),
                      height: _thumbSize,
                      width: _thumbSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorFactory.accentColor,
                        border: Border.all(color: Colors.white.withAlpha(20), width: 1),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 8, offset: const Offset(0, 2)),
                        ],
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
