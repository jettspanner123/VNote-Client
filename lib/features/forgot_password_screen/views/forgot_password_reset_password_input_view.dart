import 'package:flutter/material.dart';
import 'package:vnote_client/models/validators/input_validators.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/application_bar_component.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';
import 'package:vnote_client/shared/views/secondary_page_container.dart';

class ForgotPasswordResetPasswordInputView extends StatefulWidget {
  final TextEditingController resetPasswordController;
  final TextEditingController resetConfirmPasswordController;
  final VoidCallback? onInputFocus;

  const ForgotPasswordResetPasswordInputView({
    super.key,
    required this.resetPasswordController,
    required this.resetConfirmPasswordController,
    this.onInputFocus,
  });

  @override
  State<ForgotPasswordResetPasswordInputView> createState() => _ForgotPasswordResetPasswordInputViewState();
}

class _ForgotPasswordResetPasswordInputViewState extends State<ForgotPasswordResetPasswordInputView> {
  @override
  Widget build(BuildContext context) {
    return SecondaryScreenContainerComponent(
      children: [
        ApplicationBarComponent(children: [ApplicationBarBackButtonComponent()]),
        SecondaryScreenHeadingComponent(text: "Reset Password"),
        SecondaryScreenDescriptionComponent(
          text: "Please enter the new password that you are willing to set, please make sure you remember this one.",
        ),
        SizedBox(height: 20),
        StandardInputLabelComponent(text: "Password"),
        StandardInputField(
          onFocus: () async {
            widget.onInputFocus?.call();
          },
          validator: (value) {
            return InputValidators.current.passwordValidator(value, widget.resetConfirmPasswordController);
          },
          textController: widget.resetPasswordController,
          icon: Icon(Icons.lock),
        ),
        SizedBox(height: 20),
        StandardInputLabelComponent(text: "Confirm Password"),
        StandardInputField(
          onFocus: () async {
            widget.onInputFocus?.call();
          },
          validator: (value) {
            return InputValidators.current.passwordValidator(value, widget.resetPasswordController);
          },
          textController: widget.resetConfirmPasswordController,
          icon: Icon(Icons.lock_outline_rounded),
        ),
        SizedBox(height: 200),
      ],
    );
  }
}
