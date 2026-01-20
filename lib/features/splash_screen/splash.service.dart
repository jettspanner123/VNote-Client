import 'package:flutter/material.dart';
import 'package:vnote_client/constants/navigation_factory.dart';

class SplashScreenServices {
  Future<void> initDataLoad(BuildContext context, AnimationController animationController) async {
    // Load some data here in the future if needed

    Future.delayed(const Duration(seconds: 2), () {
      animationController.reverse().whenComplete(() {
        Navigator.pushNamed(context, NavigationFactory.landingScreen);
      });
    });
  }
}
