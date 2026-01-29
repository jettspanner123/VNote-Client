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
  void _tapDownAction(_) {
    if (_isClicked) return;
    setState(() {
      _isClicked = true;
    });
    HapticFeedback.lightImpact();
  }

  void _tapCancelAction(_) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  void _tapUpAction(_) {
    if (!_isClicked) return;
    setState(() {
      _isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _tapDownAction,
      onPointerUp: _tapUpAction,
      onPointerCancel: _tapCancelAction,
      child: GestureDetector(
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
