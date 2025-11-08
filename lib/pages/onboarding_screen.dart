import "package:client/library/window_helper_functions.dart";
import "package:flutter/material.dart";

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: WindowHelperFunctions.toggleFullScreen,
          child: Text("Toggle Full Screen"),
        ),
      ),
    );
  }
}
