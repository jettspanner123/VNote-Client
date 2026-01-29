import 'package:flutter/material.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/forgot_password_screen/forgot_password.controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/views/submit_button_with_dismiss_keyboard_button.dart';

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
          StandardButtonWithDismissKeyboardComponent(
            globalKey: submitButtonKey,
            child: StandardButtonText(text: "Submit"),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlineButtonComponent(
              onTap: () {
                NavigationFactory.current.pushPage(context, ForgotPasswordControllerScreen());
              },
              child: StandardButtonText(text: "Forgot Password?", foregroundColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
