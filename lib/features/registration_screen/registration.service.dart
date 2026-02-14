import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/utils/api_helper.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationService {
  Future<void> registerAccount({
    required GlobalKey<FormState> formState,
    required BuildContext context,
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
    required Function(String) onError,
  }) async {
    if (formState.currentState?.validate() ?? false) {
      KeyboardHelper.current.dismissKeyboad(context);

      // Api Call
      final data = await ApiFactory.current.user.createUser(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      );

      if (data == null) {
        onError("Something Went Wrong! Please try again.");
        return;
      }
      if (data.success) {
        await Future.delayed(500.milliseconds, () {
          Navigator.pushNamed(context, NavigationFactory.registrationOtpScreen);
        });
      } else {
        onError(data.message);
      }
    }
  }
}
