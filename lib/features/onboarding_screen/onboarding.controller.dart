import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.components.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.service.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';

final BLUR_AMOUNT = 12.0;

class OnboardingControllerScreen extends StatefulWidget {
  const OnboardingControllerScreen({super.key});

  @override
  State<OnboardingControllerScreen> createState() => _OnboardingControllerScreenState();
}

class _OnboardingControllerScreenState extends State<OnboardingControllerScreen> with SingleTickerProviderStateMixin {
  final onboardingService = OnboardingService();
  final PageController pageController = PageController(initialPage: 0);
  final List<String> pageIndicators = [
    "assets/images/others/man_face.png",
    "assets/images/others/women_face.png",
    "assets/images/others/old_man_face.png",
  ];

  late AnimationController _animationController;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _opacityAnimation;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _slideUpAnimation = Tween<Offset>(begin: const Offset(0, 3), end: const Offset(0, 0)).animate(curvedAnimation);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  // Action For Next / Get Started Button
  void nextButtonAction() {
    if (_currentPage != onboardingService.pages.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
    } else {
      onboardingService.completeOnboarding(context, _animationController);
    }
  }

  // Action for Skip Button
  void skipButtonAction() {
    pageController.animateToPage(
      onboardingService.pages.length - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void handlePageIndicatorAction(int index) {
    HapticFeedback.lightImpact();
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: onboardingService.pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final page = onboardingService.pages[index];
                return OnboardingPageView(
                  key: ValueKey(index),
                  title: page.title,
                  description: page.description,
                  image: page.image,
                );
              },
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: List.generate(pageIndicators.length, (index) {
                    final isActive = _currentPage == index;

                    return GestureDetector(
                      onTap: () {
                        handlePageIndicatorAction(index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.fastEaseInToSlowEaseOut,
                        height: isActive ? 50 : 30,
                        child: Opacity(
                          opacity: isActive ? 1 : 0.7,
                          child: Image.asset(pageIndicators[index], fit: BoxFit.contain),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 170),
              ],
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: _slideUpAnimation,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 30),
          child: LayoutBuilder(
            builder: (context, constrains) {
              final isLastPage = _currentPage == onboardingService.pages.length - 1;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButtonComponent(
                    onTap: skipButtonAction,
                    child: StandardButtonText(text: "Skip", foregroundColor: Colors.black),
                  ),
                  // Skip Button
                  StandardButtonComponent(
                    onTap: nextButtonAction,
                    child: AnimatedSize(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: StandardButtonPadding(
                        child: Row(
                          spacing: 5,
                          children: [
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              key: ValueKey(isLastPage),
                              child: Text(
                                isLastPage ? "Get Started" : "Next",
                                style: GoogleFonts.funnelSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(isLastPage ? Icons.check : Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Page Indicator

                  // Dual Action Button
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
