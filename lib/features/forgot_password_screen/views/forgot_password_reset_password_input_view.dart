import 'package:flutter/material.dart';

class ForgotPasswordResetPasswordInputView extends StatefulWidget {
  final TextEditingController resetPasswordController;
  final TextEditingController resetConfirmPasswordController;
  const ForgotPasswordResetPasswordInputView({
    super.key,
    required this.resetPasswordController,
    required this.resetConfirmPasswordController,
  });

  @override
  State<ForgotPasswordResetPasswordInputView> createState() => _ForgotPasswordResetPasswordInputViewState();
}

class _ForgotPasswordResetPasswordInputViewState extends State<ForgotPasswordResetPasswordInputView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
