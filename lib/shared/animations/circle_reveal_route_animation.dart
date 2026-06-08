import 'dart:math';

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Clipper — cuts the screen to a growing circle
// ---------------------------------------------------------------------------

class _CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  const _CircularRevealClipper({required this.fraction, required this.center});

  @override
  Path getClip(Size size) {
    final maxRadius = sqrt(
      pow(max(center.dx, size.width - center.dx), 2) + pow(max(center.dy, size.height - center.dy), 2),
    );
    final radius = maxRadius * fraction;
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(_CircularRevealClipper old) => old.fraction != fraction || old.center != center;
}

// ---------------------------------------------------------------------------
// Shadow painter — draws a dark halo just outside the clip circle edge
// ---------------------------------------------------------------------------

class _CircularShadowPainter extends CustomPainter {
  final double fraction;
  final Offset center;

  _CircularShadowPainter({required this.fraction, required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    if (fraction <= 0 || fraction >= 1) return;

    final maxRadius = sqrt(
      pow(max(center.dx, size.width - center.dx), 2) + pow(max(center.dy, size.height - center.dy), 2),
    );
    final radius = maxRadius * fraction;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.transparent, Colors.black.withAlpha(0), Colors.black.withAlpha(80), Colors.black.withAlpha(0)],
        stops: const [0.0, 0.88, 0.97, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius + 30))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawCircle(center, radius + 10, paint);
  }

  @override
  bool shouldRepaint(_CircularShadowPainter old) => old.fraction != fraction || old.center != center;
}

// ---------------------------------------------------------------------------
// Page route
// ---------------------------------------------------------------------------

class CircularRevealRoute extends PageRoute<void> {
  final WidgetBuilder builder;
  final Offset originCenter;

  CircularRevealRoute({required this.builder, required this.originCenter});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 550);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 550);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: const Cubic(0.85, 0.0, 0.15, 1.0),
      reverseCurve: const Cubic(0.85, 0.0, 0.15, 1.0),
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (_, __) {
        final fraction = curved.value;
        return CustomPaint(
          foregroundPainter: _CircularShadowPainter(fraction: fraction, center: originCenter),
          child: ClipPath(
            clipper: _CircularRevealClipper(fraction: fraction, center: originCenter),
            child: child,
          ),
        );
      },
    );
  }
}
