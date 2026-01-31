import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationFactory {
  static final current = NavigationFactory();

  static const String splashScreen = '/splash';
  static const String landingScreen = '/landing';
  static const String onboardingScreen = '/onboarding';
  static const String questionareScreen = '/questionare';
  static const String registrationScreen = "/registration";
  static const String forgotPasswordScreen = "/forogt-password";
  static const String successPage = "/success";
  static const String registrationOtpScreen = "/registration-otp";
  static const String welcomeScreen = "/welcome";
  static const String registrationWelcomeScreen = "/registration-welcome";
  static const String languageSelectorScreen = "/language-selector";

  static const String homeScreen = "/home-screen";
  Future pushPage(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      Platform.isIOS ? CupertinoPageRoute(builder: (_) => page) : MaterialPageRoute(builder: (_) => page),
    );
  }
}
