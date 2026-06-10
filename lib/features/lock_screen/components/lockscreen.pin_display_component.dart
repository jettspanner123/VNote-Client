import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/lock_screen/constants/lockscreen.constants.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LockScreenPinDisplayComponent extends StatelessWidget {
  final String enteredPin;

  const LockScreenPinDisplayComponent({super.key, required this.enteredPin});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final filledColor = UIHelper.current.getValueAccordingToColorMode(
      colorMode: globalColorModeBloc.state.colorMode,
      darkValue: Colors.white,
      lightValue: const Color(0xFF06140D),
    );
    final emptyColor = UIHelper.current.getValueAccordingToColorMode(
      colorMode: globalColorModeBloc.state.colorMode,
      darkValue: Colors.white24,
      lightValue: const Color(0xFFCCCCCC),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(LockScreenConstants.current.PIN_LENGTH, (index) {
        final isFilled = index < enteredPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: isFilled ? 16 : 14,
          height: isFilled ? 16 : 14,
          decoration: BoxDecoration(color: isFilled ? filledColor : emptyColor, shape: BoxShape.circle),
        );
      }),
    );
  }
}
