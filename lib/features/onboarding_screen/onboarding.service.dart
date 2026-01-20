import "package:flutter/material.dart";
import "package:vnote_client/constants/navigation_factory.dart";

import "../../models/auth/onboarding/onboarding_data.dart";

class OnboardingService {
  final List<OnboardingData> pages = const [
    OnboardingData(
      title: "Effortlessly record monetary transactions",
      description: "Quickly add who owes you money and the exact amount.",
      image: "assets/images/onboarding_images/onboarding_one.png",
    ),
    OnboardingData(
      title: "Keep every customer record organized",
      description: "Manage names, amounts, and notes neatly in one simple list.",
      image: "assets/images/onboarding_images/onboarding_two.png",
    ),
    OnboardingData(
      title: "Never miss pending payment reminders",
      description: "See all pending dues clearly and collect payments on time.",
      image: "assets/images/onboarding_images/onboarding_three.png",
    ),
  ];

  Future<void> completeOnboarding(BuildContext context, AnimationController animationController) async {
    animationController.reverse().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 250));
      Navigator.pushNamed(context, NavigationFactory.registrationScreen);
    });
  }
}
