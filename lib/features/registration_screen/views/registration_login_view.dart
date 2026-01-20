import 'package:flutter/material.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationLoginView extends StatefulWidget {
  const RegistrationLoginView({super.key});

  @override
  State<RegistrationLoginView> createState() => _RegistrationLoginViewState();
}

class _RegistrationLoginViewState extends State<RegistrationLoginView> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final submitButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom > 0;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20),
          StandardInputField(
            textController: _phoneNumberController,
            placeholder: "Enter Phone Number",
            icon: Icon(Icons.phone),
            onFocus: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              Scrollable.ensureVisible(submitButtonKey.currentContext!, duration: const Duration(milliseconds: 500));
            },
          ),
          SizedBox(height: 10),
          StandardInputField(
            textController: _passwordController,
            placeholder: "Enter Password",
            icon: Icon(Icons.lock),
            onFocus: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              Scrollable.ensureVisible(submitButtonKey.currentContext!, duration: const Duration(milliseconds: 500));
            },
          ),

          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: Row(
              spacing: 5,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isKeyboardUp
                        ? OutlineButtonComponent(
                            child: StandardButtonPadding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            onTap: () {
                              KeyboardHelper.current.dismissKeyboad(context);
                            },
                          )
                        : SizedBox.shrink(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: StandardButtonComponent(
                    key: submitButtonKey,
                    child: StandardButtonText(text: "Create Account"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
