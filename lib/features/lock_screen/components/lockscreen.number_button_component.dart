import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/lock_screen/constants/lockscreen.constants.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LockScreenNumberButtonComponent extends StatefulWidget {
  final String value;
  final VoidCallback onTap;

  const LockScreenNumberButtonComponent({super.key, required this.value, required this.onTap});

  @override
  State<LockScreenNumberButtonComponent> createState() => _LockScreenNumberButtonComponentState();
}

class _LockScreenNumberButtonComponentState extends State<LockScreenNumberButtonComponent> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorMode = context.watch<GlobalColorModeControllerBloc>().state.colorMode;
    final isBackspace = widget.value == LockScreenConstants.current.NUMBER_BUTTON_BACKSPACE_IDENTIFIER;
    final isEmpty = widget.value == LockScreenConstants.current.NUMBER_BUTTON_EMPTY_IDENTIFIER;

    if (isEmpty) return const SizedBox.shrink();

    // Normal bg/fg
    final normalBg = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: const Color(0xFF2A2A2A),
      lightValue: const Color(0xFFF1F4F3),
    );
    final normalFg = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: Colors.white,
      lightValue: Colors.black,
    );

    final normalBorder = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: Colors.white.withAlpha(30),
      lightValue: Colors.black.withAlpha(30),
    );

    // Pressed bg/fg — inverted feel
    final pressedBg = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: Colors.white,
      lightValue: Colors.black,
    );
    final pressedFg = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: Colors.black,
      lightValue: Colors.white,
    );

    final bg = _isPressed ? pressedBg : normalBg;
    final fg = _isPressed ? pressedFg : normalFg;

    return Listener(
      onPointerDown: (_) {
        HapticFeedback.lightImpact();
        setState(() => _isPressed = true);
      },
      onPointerUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onPointerCancel: (_) => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          decoration: BoxDecoration(
            color: bg,
            border: BoxBorder.all(width: 1, color: normalBorder),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isBackspace
                ? Icon(Icons.backspace_outlined, size: 24, color: fg)
                : Text(
                    widget.value,
                    style: UIHelper.current.funnelTextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: fg),
                  ),
          ),
        ),
      ),
    );
  }
}
