import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/lock_screen/components/lockscreen.pin_display_component.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LockScreenPinDisplayController extends StatelessWidget {
  final String enteredPin;

  const LockScreenPinDisplayController({super.key, required this.enteredPin});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
      decoration: BoxDecoration(
        color: UIHelper.current.getValueAccordingToColorMode(
          colorMode: globalColorModeBloc.state.colorMode,
          darkValue: const Color(0xFF2A2A2A),
          lightValue: const Color(0xFFF1F4F3),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          LockScreenPinDisplayComponent(enteredPin: enteredPin),
          const SizedBox(height: 8),
          Text(
            "Enter PIN",
            style: UIHelper.current.funnelTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: UIHelper.current.getValueAccordingToColorMode(
                colorMode: globalColorModeBloc.state.colorMode,
                darkValue: Colors.white70,
                lightValue: const Color(0xFF6D7773),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
