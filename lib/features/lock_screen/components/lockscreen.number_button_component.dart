import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/lock_screen/constants/lockscreen.constants.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LockScreenNumberButtonComponent extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const LockScreenNumberButtonComponent({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final isBackspace = value == LockScreenConstants.current.NUMBER_BUTTON_BACKSPACE_IDENTIFIER;
    final isEmpty = value == LockScreenConstants.current.NUMBER_BUTTON_EMPTY_IDENTIFIER;

    // Empty cell — invisible, non-interactive spacer
    if (isEmpty) return const SizedBox.shrink();

    return OnTapScaleInteractionComponent(
      onTap: onTap,
      config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
      child: Container(
        decoration: BoxDecoration(
          color: UIHelper.current.getValueAccordingToColorMode(
            colorMode: globalColorModeBloc.state.colorMode,
            darkValue: const Color(0xFF2A2A2A),
            lightValue: const Color(0xFFF1F4F3),
          ),
          border: BoxBorder.all(width: 1, color: Colors.white.withAlpha(20)),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isBackspace
              ? Icon(
                  Icons.backspace_outlined,
                  size: 24,
                  color: UIHelper.current.getValueAccordingToColorMode(
                    colorMode: globalColorModeBloc.state.colorMode,
                    darkValue: Colors.white,
                    lightValue: Colors.black,
                  ),
                )
              : ColorModeAwareTextComponent(
                  text: value,
                  style: UIHelper.current.funnelTextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
