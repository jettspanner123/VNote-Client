import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.components.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.service.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';

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
  late Animation<Offset> _slideDownAnimation;
  late Animation<double> _scaleUpAnimation;
  late Animation<Offset> _slideUpAnimation;

  int _currentPage = 0;

  // Action For Next / Get Started Button
  void nextButtonAction() {
    if (_currentPage != onboardingService.pages.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
      return;
    }
    _animationController.reverse().whenComplete(() {
      onboardingService.completeOnboarding(context);
    });
  }

  // Action for Skip Button
  void skipButtonAction() {
    if (_currentPage == onboardingService.pages.length - 1) {
      pageController.animateToPage(0, duration: 500.milliseconds, curve: Curves.fastEaseInToSlowEaseOut);
      return;
    }
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
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: 1.seconds);

    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _slideDownAnimation = Tween<Offset>(begin: const Offset(0, -1.2), end: const Offset(0, 0)).animate(curvedAnimation);
    _scaleUpAnimation = Tween<double>(begin: 1, end: 0).animate(curvedAnimation);
    _slideUpAnimation = Tween<Offset>(
      begin: Offset(0, 3),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SlideTransition(
        position: _slideDownAnimation,
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
                  AnimatedSwitcher(
                    duration: 500.milliseconds,
                    transitionBuilder: (child, animation) {
                      final slideDownTransition = Tween<Offset>(
                        begin: Offset(0, 2),
                        end: Offset(0, 0),
                      ).animate(CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut));
                      return SlideTransition(position: slideDownTransition, child: child);
                    },
                    child: !isLastPage
                        ? OutlineButtonComponent(
                            onTap: skipButtonAction,
                            child: AnimatedSwitcher(
                              duration: 500.milliseconds,
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(scale: animation, child: child);
                              },
                              child: StandardButtonText(text: "Skip", foregroundColor: Colors.black),
                            ),
                          )
                        : SizedBox.shrink(),
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
                ],
              ).animate().slideY(
                begin: 2,
                end: 0,
                duration: 700.milliseconds,
                delay: 500.milliseconds,
                curve: Curves.fastEaseInToSlowEaseOut,
              );
            },
          ),
        ),
      ),
    );
  }
}
