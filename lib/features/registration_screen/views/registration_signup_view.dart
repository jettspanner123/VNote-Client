import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/models/validators/input_validators.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegisterSignUpView extends StatefulWidget {
  const RegisterSignUpView({super.key});

  @override
  State<RegisterSignUpView> createState() => _RegisterSignUpViewState();
}

class _RegisterSignUpViewState extends State<RegisterSignUpView>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final submitButtonKey = GlobalKey();

  bool isKeyboardUp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final newValue = bottomInset > 0;

    if (newValue != isKeyboardUp) {
      setState(() {
        isKeyboardUp = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20),
          StandardInputField(
            textController: _phoneNumberController,
            icon: Icon(Icons.phone),
            placeholder: "Enter Phone Number",
            keyboardType: TextInputType.number,
            validator: InputValidators.current.phoneNumberValidator,
            onFocus: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              Scrollable.ensureVisible(submitButtonKey.currentContext!, duration: const Duration(milliseconds: 500));
            },
          ),
          SizedBox(height: 10),
          StandardInputField(
            textController: _passwordController,
            icon: Icon(Icons.lock),
            placeholder: "Enter Password",
          ),
          SizedBox(height: 10),
          StandardInputField(
            textController: _confirmPasswordController,
            icon: Icon(Icons.lock_outline),
            placeholder: "Confirm Password",
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

          SizedBox(height: 10),

          // Sign Up with Google Button
          OutlineButtonComponent(
            child: StandardButtonPadding(
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/google.png", height: 18),
                  Text("Sign Up With Google", style: GoogleFonts.funnelSans(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
