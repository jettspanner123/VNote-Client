import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/constants/component_constants.dart';

class StandardButtonComponent extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color backgroundColor;
  final double borderRadius;
  final int animationDuration;
  final bool wantTapAnimation;
  final Color loadingStateColor;

  const StandardButtonComponent({
    super.key,
    required this.child,
    this.onTap,
    this.isLoading = false,
    this.backgroundColor = Colors.black,
    this.borderRadius = 100,
    this.animationDuration = 25,
    this.wantTapAnimation = true,
    this.loadingStateColor = Colors.white,
  });

  @override
  State<StandardButtonComponent> createState() => _StandardButtonComponentState();
}

class _StandardButtonComponentState extends State<StandardButtonComponent> {
  bool _isClicked = false;
  void _tapDownAction(TapDownDetails _) {
    if (_isClicked) return;
    setState(() {
      _isClicked = true;
    });
    HapticFeedback.lightImpact();
  }

  void _tapCancelAction() {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  void _tapUpAction(TapUpDetails _) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDownAction,
      onTapUp: _tapUpAction,
      onTapCancel: _tapCancelAction,
      onTap: () {
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: !widget.wantTapAnimation
            ? 1
            : _isClicked
            ? 0.95
            : 1.0,
        duration: Duration(milliseconds: widget.animationDuration),
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.animationDuration),
          decoration: BoxDecoration(
            color: !widget.wantTapAnimation
                ? widget.backgroundColor
                : _isClicked
                ? ColorFactory.accentColor
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut);
              return ScaleTransition(
                scale: curvedAnimation,
                child: FadeTransition(opacity: curvedAnimation, child: child),
              );
            },
            child: widget.isLoading
                ? Padding(
                    padding: ComponentConstants.standardButtonPadding,
                    child: CupertinoActivityIndicator(color: widget.loadingStateColor, radius: 11),
                  )
                : widget.child,
          ),
        ),
      ),
    );
  }
}
