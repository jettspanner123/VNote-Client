import 'package:flutter/material.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/landing_screen/landing.controller.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.controller.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/features/registration_screen/registration.controller.dart';
import 'package:vnote_client/features/splash_screen/splash.controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VNote',
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationFactory.onboardingScreen,
      routes: {
        NavigationFactory.splashScreen: (context) => const SplashScreenController(),
        NavigationFactory.landingScreen: (context) => const LandingControllerScreen(),
        NavigationFactory.onboardingScreen: (context) => const OnboardingControllerScreen(),
        NavigationFactory.questionareScreen: (context) => const QuestionareControllerScreen(),
        NavigationFactory.registrationScreen: (context) => const RegistrationControllerScreen(),
      },
    );
  }
}
