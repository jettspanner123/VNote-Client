import 'dart:math';

import 'package:flutter/material.dart';

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
        final curved = CurvedAnimation(parent: animation, curve: const Cubic(0.85, 0.0, 0.15, 1.0), reverseCurve: const Cubic(0.85, 0.0, 0.15, 1.0));
        return AnimatedBuilder(
            animation: curved,
            builder: (_, __) => ClipPath(
                clipper: _CircularRevealClipper(fraction: curved.value, center: originCenter),
                child: child,
            ),
        );
    }
}
