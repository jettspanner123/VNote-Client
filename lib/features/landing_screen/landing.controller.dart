import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';

class LandingControllerScreen extends StatefulWidget {
  const LandingControllerScreen({super.key});

  @override
  State<LandingControllerScreen> createState() => _LandingControllerScreenState();
}

class _LandingControllerScreenState extends State<LandingControllerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _imageOffsetAnimation;
  late Animation<Offset> _buttonOffsetAnimation;
  late Animation<Offset> _titlePrimaryOffsetAnimation;
  late Animation<Offset> _titleSecondaryOffsetAnimation;
  late Animation<Offset> _titleTertiaryOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    final curvedAnimationState = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);

    _imageOffsetAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    _buttonOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(curvedAnimationState);

    _titlePrimaryOffsetAnimation = Tween<Offset>(begin: const Offset(-1.2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    _titleSecondaryOffsetAnimation = Tween<Offset>(begin: const Offset(-1.2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    _titleTertiaryOffsetAnimation = Tween<Offset>(begin: const Offset(-1.2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onGetStartedButtonTap() {
    _animationController.reverse();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, NavigationFactory.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Top Text
            SizedBox(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.funnelSans(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.1,
                        ),
                        children: [
                          WidgetSpan(
                            child: SlideTransition(
                              position: _titlePrimaryOffsetAnimation,
                              child: Text(
                                "Stop losing ",
                                style: GoogleFonts.funnelSans(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),

                          WidgetSpan(
                            child: SlideTransition(
                              position: _titleSecondaryOffsetAnimation,
                              child: Text(
                                "money.",
                                style: GoogleFonts.funnelSans(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: ColorFactory.accentColor,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),

                          WidgetSpan(
                            child: SlideTransition(
                              position: _titleTertiaryOffsetAnimation,
                              child: Text(
                                "Track Instantly.",
                                style: GoogleFonts.funnelSans(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Image
            SlideTransition(
              position: _imageOffsetAnimation,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Transform.translate(
                      offset: const Offset(-20, -80),
                      child: Image.asset("assets/images/others/landing_page_image.png", height: 450),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: SlideTransition(
            position: _buttonOffsetAnimation,
            child: StandardButtonComponent(
              onTap: onGetStartedButtonTap,
              child: StandardButtonText(text: "Get Started"),
            ),
          ),
        ),
      ),
    );
  }
}
