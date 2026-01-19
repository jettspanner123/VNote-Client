import 'package:flutter/material.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.controller.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnboardingControllerScreen());
  }
}
