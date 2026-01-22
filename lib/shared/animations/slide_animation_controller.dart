import 'package:flutter/material.dart';

class SlideAnimationValue {
  final Offset begin;
  final Offset end;

  SlideAnimationValue({required this.begin, required this.end});
}

class SlideAnimationControllerComponent extends StatefulWidget {
  final SlideAnimationValue slideOffset;
  final Widget? child;
  final Duration? duration;
  const SlideAnimationControllerComponent({super.key, required this.slideOffset, this.child, this.duration});

  @override
  State<SlideAnimationControllerComponent> createState() => _SlideAnimationControllerComponentState();
}

class _SlideAnimationControllerComponentState extends State<SlideAnimationControllerComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration ?? Duration(milliseconds: 500));
    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _animation = Tween<Offset>(begin: widget.slideOffset.begin, end: widget.slideOffset.end).animate(curvedAnimation);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}
