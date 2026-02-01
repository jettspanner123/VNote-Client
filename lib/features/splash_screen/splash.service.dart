import 'package:flutter/material.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/language_selector_screen/language.controller.dart';

class SplashScreenServices {
  Future<void> initDataLoad(BuildContext context, AnimationController animationController) async {
    // Load some data here in the future if needed

    Future.delayed(const Duration(seconds: 2), () {
      animationController.reverse().whenComplete(() {
        NavigationFactory.current.replacePage(context, LanguageSelectorController());
      });
    });
  }
}
