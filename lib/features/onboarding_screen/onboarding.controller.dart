import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.components.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.service.dart';

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
                // Skip Button
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      reverseCurve: Curves.fastEaseInToSlowEaseOut,
                    );

                    final slideTransitionValue = Tween<Offset>(
                      begin: const Offset(0, 2),
                      end: const Offset(0, 0),
                    ).animate(curvedAnimation);
                    return SlideTransition(position: slideTransitionValue, child: child);
                  },
                  child: _currentPage != onboardingService.pages.length - 1
                      ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: BoxBorder.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 15),
                              child: Text(
                                "Skip",
                                style: GoogleFonts.funnelSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),

                // Page Indicator

                // Dual Action Button
                GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    width: isLastPage ? constrains.maxWidth : 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == onboardingService.pages.length - 1 ? "Get Started" : "Next",
                            style: GoogleFonts.funnelSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          Icon(
                            _currentPage == onboardingService.pages.length - 1 ? Icons.check : Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
