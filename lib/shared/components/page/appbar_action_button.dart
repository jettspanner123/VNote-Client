import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../interaction/tap_scale_interaction.dart';

class AppbarActionButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Widget? expandInto;

  AppbarActionButton({super.key, this.onTap, this.expandInto, required this.child});

  @override
  State<AppbarActionButton> createState() => _AppbarActionButtonState();
}

class _AppbarActionButtonState extends State<AppbarActionButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasExpandedState = widget.expandInto != null;
    final borderRadiusValue = hasExpandedState ? (_isExpanded ? 20.0 : 100.0) : 100.0;

    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(end: Offset(_isExpanded ? 10 : 0, _isExpanded ? 10 : 0)),
      duration: 300.milliseconds,
      curve: Curves.fastEaseInToSlowEaseOut,
      builder: (context, offset, child) {
        return Transform.translate(offset: offset, child: child);
      },
      child: OnTapScaleInteractionComponent(
        onTap: () {
          widget.onTap?.call();
          if (!hasExpandedState) return;

          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        config: OnTapScaleInteractionValue.normalInteraction(),
        child: AnimatedContainer(
          duration: 300.milliseconds,
          curve: Curves.fastEaseInToSlowEaseOut,
          height: hasExpandedState ? (_isExpanded ? 200 : 50) : 50,
          width: hasExpandedState ? (_isExpanded ? 200 : 50) : 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadiusValue),
            border: BoxBorder.all(color: Colors.black.withAlpha(30), width: 1),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            child: AnimatedSwitcher(
              duration: 200.milliseconds,
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                final fadeAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                  reverseCurve: Curves.easeIn,
                );
                final blurTween = Tween<double>(begin: 8, end: 0);

                return AnimatedBuilder(
                  animation: animation,
                  child: child,
                  builder: (context, animatedChild) {
                    final sigma = blurTween.evaluate(animation);
                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                        child: animatedChild,
                      ),
                    );
                  },
                );
              },
              child: Center(
                key: ValueKey<bool>(_isExpanded),
                child: hasExpandedState && _isExpanded ? widget.expandInto! : widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
