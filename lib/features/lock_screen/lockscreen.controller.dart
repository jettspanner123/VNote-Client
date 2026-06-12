import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/lock_screen/components/lockscreen.number_button_controller.dart';
import 'package:vnote_client/features/lock_screen/components/lockscreen.pin_display_controller.dart';
import 'package:vnote_client/features/lock_screen/constants/lockscreen.constants.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LockScreenController extends StatefulWidget {
  const LockScreenController({super.key});

  @override
  State<LockScreenController> createState() => _LockScreenControllerState();
}

class _LockScreenControllerState extends State<LockScreenController> {
  String _enteredPin = "";

  void _onButtonTap(String value) {
    final backspace = LockScreenConstants.current.NUMBER_BUTTON_BACKSPACE_IDENTIFIER;
    final empty = LockScreenConstants.current.NUMBER_BUTTON_EMPTY_IDENTIFIER;
    final maxLength = LockScreenConstants.current.PIN_LENGTH;

    if (value == empty) return;

    setState(() {
      if (value == backspace) {
        if (_enteredPin.isNotEmpty) {
          _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
        }
      } else if (_enteredPin.length < maxLength) {
        _enteredPin += value;
      }
    });

    // Auto-submit when all 6 digits are entered.
    if (_enteredPin.length == maxLength) {
      _onPinComplete(_enteredPin);
    }
  }

  void _onPinComplete(String pin) {
    // Handle PIN validation here.
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();

    UIHelper.current.setStatusBarColors(globalColorModeBloc.state.colorMode);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: UIHelper.current.getValueAccordingToColorMode(
        colorMode: globalColorModeBloc.state.colorMode,
        darkValue: Color.fromARGB(255, 23, 23, 23),
        lightValue: Colors.white,
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PIN display card
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Image.asset(
                      "assets/images/others/splash_screen_logo_transparent.png",
                      height: 120,
                      width: 70,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                LockScreenPinDisplayController(enteredPin: _enteredPin),
                const SizedBox(height: 40),

                // Number pad — fixed height so it doesn't stretch
                Expanded(child: LockScreenNumberButtonController(onButtonTap: _onButtonTap)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //   floatingActionButton: FloatingButtonHolderComponent(
      //     child: OnTapScaleInteractionComponent(
      //       config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
      //       child: StandardButtonText(text: "Forgot App Code?"),
      //     ),
      //   ),
    );
  }
}
