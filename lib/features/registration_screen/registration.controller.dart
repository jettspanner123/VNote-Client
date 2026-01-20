import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/registration_screen/registration.components.dart';
import 'package:vnote_client/models/frontend/segment_control.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/segment/segmented_controller.dart';

class RegistrationControllerScreen extends StatefulWidget {
  const RegistrationControllerScreen({super.key});

  @override
  State<RegistrationControllerScreen> createState() => _RegistrationControllerScreenState();
}

enum RegistrationControllerScreenOptions { register, login }

class _RegistrationControllerScreenState extends State<RegistrationControllerScreen> {
  RegistrationControllerScreenOptions selectedScreen = RegistrationControllerScreenOptions.register;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Main content
      body: SafeArea(
        child: Padding(
          padding: ComponentConstants.screenHorizontalPadding,
          child: SingleChildScrollView(
            child: Column(
              spacing: 0,
              children: [
                // Hero Image
                Container(
                  color: Colors.blue,
                  height: 240,
                  child: Image.asset("assets/images/others/registration_screen_main.png", height: 300),
                ),

                // Registration Type Segment
                Transform.translate(
                  offset: const Offset(0, -8),
                  child: SegmentedController<RegistrationControllerScreenOptions>(
                    selected: selectedScreen,
                    onSelectionChange: (newValue) {
                      setState(() {
                        selectedScreen = newValue;
                      });
                    },
                    segments: [
                      SegmentControl(value: RegistrationControllerScreenOptions.register, label: "Register"),
                      SegmentControl(value: RegistrationControllerScreenOptions.login, label: "Login"),
                    ],
                  ),
                ),

                // Register and Login Views
                selectedScreen == RegistrationControllerScreenOptions.register
                    ? const RegisterSignUpView()
                    : const Text("Login View"),
              ],
            ),
          ),
        ),
      ),

      // Bottom Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: SizedBox(
          width: double.infinity,
          child: StandardButtonComponent(
            onTap: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
            isLoading: isLoading,
            child: StandardButtonText(text: "Register"),
          ),
        ),
      ),
    );
  }
}
