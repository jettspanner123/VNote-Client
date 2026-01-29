import 'package:flutter/material.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationService {
  void registerAccount(GlobalKey<FormState> formState, BuildContext context) async {
    // if (formState.currentState?.validate() ?? false) {
    //   KeyboardHelper.current.dismissKeyboad(context);
    //   await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pushNamed(context, NavigationFactory.registrationOtpScreen);
    // }
  }
}
