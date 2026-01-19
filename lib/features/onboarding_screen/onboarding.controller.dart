import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/constants/component_constants.dart';
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

class _OnboardingControllerScreenState extends State<OnboardingControllerScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final onboardingService = OnboardingService();

  int _currentPage = 0;

  // Action For Next / Get Started Button
  void nextButtonAction() {
    if (_currentPage != onboardingService.pages.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
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
          return OnboardingPageView(title: page.title, description: page.description, image: page.image);
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
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
    );
  }
}
