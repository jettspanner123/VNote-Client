import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class ApplicationBarDismissButtonComponent extends StatefulWidget {
  final VoidCallback? onTap;
  const ApplicationBarDismissButtonComponent({super.key, this.onTap});

  @override
  State<ApplicationBarDismissButtonComponent> createState() => ApplicationBarDismissButtonComponentState();
}

class ApplicationBarDismissButtonComponentState extends State<ApplicationBarDismissButtonComponent> {
  bool isTapped = false;

  void _handleTapDown(_) {
    if (!isTapped) {
      setState(() {
        isTapped = true;
      });
    }
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(_) {
    if (isTapped) {
      setState(() {
        isTapped = false;
      });
    }
  }

  void _handleTapCancel(_) {
    if (isTapped) {
      setState(() {
        isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    final backgroundColor = UIHelper.current.getForegroundColorForColorMode(colorMode);
    final borderColor = colorMode == AppColorMode.DARK ? Colors.white.withAlpha(40) : Colors.black.withAlpha(40);
    final iconColor = UIHelper.current.getTextColorForColorMode(colorMode);

    return Transform.translate(
      offset: const Offset(0, 10),
      child: Listener(
        onPointerDown: _handleTapDown,
        onPointerUp: _handleTapUp,
        onPointerCancel: _handleTapCancel,
        child: GestureDetector(
          onTap:
              widget.onTap ??
              () {
                Navigator.of(context).pop();
              },
          child: AnimatedScale(
            scale: isTapped ? 0.95 : 1,
            duration: const Duration(milliseconds: 100),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadiusDirectional.circular(100),
              ),
              child: Icon(Icons.close, color: iconColor, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
