// MARK: Package Imports
import "package:client/components/static/registration_screen_graphic_section.dart";
import "package:client/models/sign_up_section_onboarding_progress_options.dart";
import "package:flutter/material.dart";

// MARK: Components Import
import "../components/static/sign_up_screen.dart";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  SignUpSectionOnboardingOptions currentSelectedOnboarding =
      SignUpSectionOnboardingOptions.personAccountSetup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        color: Colors.white,
        child: Row(
          children: [
            // MARK: Graphics Section
            RegistrationScreenGraphicSection(
              currentSelectedOnboarding: currentSelectedOnboarding,
            ),

            // MARK: Content Section
            SignUpScreen(),
          ],
        ),
      ),
    );
  }
}
