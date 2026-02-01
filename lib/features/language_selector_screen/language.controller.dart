import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/language_selector_screen/language.component.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/utils/ui_helper.dart';

enum Language { hindi, english, punjabi, hinglish, tamil, telugu }

final List<(Language language, String image)> LANGUAGE_OPTIONS = [
  (Language.english, "assets/images/languages/english.png"),
  (Language.hindi, "assets/images/languages/hindi.png"),
  (Language.punjabi, "assets/images/languages/punjabi.png"),
  (Language.hinglish, "assets/images/languages/hinglish.png"),
  (Language.tamil, "assets/images/languages/tamil.png"),
  (Language.telugu, "assets/images/languages/telgu.png"),
];

class LanguageSelectorController extends StatefulWidget {
  const LanguageSelectorController({super.key});

  @override
  State<LanguageSelectorController> createState() => LanguageSelectorControllerState();
}

class LanguageSelectorControllerState extends State<LanguageSelectorController> with SingleTickerProviderStateMixin {
  Language selectedLanguage = Language.english;

  late AnimationController _animationController;
  late Animation<Offset> _topSlideAnimation;
  late Animation<Offset> _bottomSlideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: 1.seconds);
    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _topSlideAnimation = Tween<Offset>(begin: const Offset(0, -1.2), end: const Offset(0, 0)).animate(curvedAnimation);
    _bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLanguageSelection() async {
    // TODO: Set the selected language as the user's prefered language

    _animationController.reverse();
    await Future.delayed(1.2.seconds);
    NavigationFactory.current.replacePage(context, const OnboardingControllerScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: ComponentConstants.screenHorizontalPadding,
          children: [
            SlideTransition(
              position: _topSlideAnimation,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Select Your Prefered Language",
                    style: UIHelper.current.funnelTextStyle(fontSize: 35, fontWeight: FontWeight.bold, height: 1.05),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Select your preferred language to continue. You can change it later from settings.",
                    style: UIHelper.current.funnelTextStyle(fontSize: 18, color: Colors.black.withAlpha(110)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SlideTransition(
              position: _bottomSlideAnimation,
              child: GridView.builder(
                itemCount: LANGUAGE_OPTIONS.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final language = LANGUAGE_OPTIONS[index];
                  return LanguageOption(
                    selectedLanguage: selectedLanguage,
                    language: language,
                    onTap: () {
                      setState(() {
                        selectedLanguage = language.$1;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingButtonHolderComponent(
          child: SizedBox(
            width: double.infinity,
            child: StandardButtonComponent(
              onTap: _handleLanguageSelection,
              child: StandardButtonText(text: "Continue"),
            ),
          ),
        ),
      ),
    );
  }
}
