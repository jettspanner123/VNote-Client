import 'package:flutter/material.dart';
import 'package:vnote_client/features/forgot_password_screen/forgot_password.controller.dart';
import 'package:vnote_client/features/helper_screens/success_screen.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class ForgotPasswordServices {
  Future<ForgotPasswordScreenOptions?> handlePrimaryButtonAction(
    BuildContext context,
    ForgotPasswordScreenOptions currentScreen,
    GlobalKey<FormState> forgotPasswordFormKey,
    GlobalKey<FormState> forgotPasswordOtpFormKey,
  ) async {
    if (currentScreen == ForgotPasswordScreenOptions.phoneNumberInput) {
      if (forgotPasswordFormKey.currentState?.validate() ?? false) {
        KeyboardHelper.current.dismissKeyboad(context);
        await Future.delayed(const Duration(milliseconds: 500));

        // TODO: Check phone in DB
        // TODO: Send OTP

        return ForgotPasswordScreenOptions.otpInput;
      }
      return null;
    }

    if (currentScreen == ForgotPasswordScreenOptions.otpInput) {
      if (forgotPasswordOtpFormKey.currentState?.validate() ?? false) {
        KeyboardHelper.current.dismissKeyboad(context);
        await Future.delayed(const Duration(milliseconds: 500));

        // TODO: Check OTP

        return ForgotPasswordScreenOptions.resetPasswordInput;
      }
      return null;
    }

    // RESET PASSWORD SCREEN
    KeyboardHelper.current.dismissKeyboad(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 200,
            color: Colors.white,
            child: const SuccessControllerScreen(
              badgeIconSize: 200,
              heading: "Forgot Password",
              description: "Your password has been successfully reset. You can now use the password to login again.",
              navigationButtonText: "Go Back To Login Page",
            ),
          ),
        );
      },
    );

    return null;
  }

  void resendOtp() {}
}
