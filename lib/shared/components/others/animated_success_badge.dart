import 'package:flutter/material.dart';

class AnimatedSuccessBadgeComponent extends StatefulWidget {
  final double size;
  const AnimatedSuccessBadgeComponent({super.key, this.size = 250});

  @override
  State<AnimatedSuccessBadgeComponent> createState() => _AnimatedSuccessBadgeComponentState();
}

class _AnimatedSuccessBadgeComponentState extends State<AnimatedSuccessBadgeComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _infiniteAnimationController;
  late final Animation<double> _infiniteRotateAnimation;

  @override
  void initState() {
    super.initState();

    _infiniteAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _infiniteRotateAnimation = Tween<double>(begin: 0, end: 1).animate(_infiniteAnimationController);
  }

  @override
  void dispose() {
    _infiniteAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      color: Colors.white,
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          RotationTransition(
            turns: _infiniteRotateAnimation,
            child: Image.asset("assets/images/success_badge/success_bg.png"),
          ),
          Image.asset("assets/images/success_badge/success_fg.png", height: widget.size * 0.28),
        ],
      ),
    );
  }
}
