// MARK: Core Imports
import "dart:ui";

// MARK: Package Imports
import "package:client/store/theme_provider.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:video_player/video_player.dart";

// MARK: Components Import
import "../components/static/current_registration_state_widget.dart";
import "../components/static/registration_option_button.dart";
import "../components/static/registration_form_submit_button.dart";
import "../components/shared/custom_text_field.dart";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = VideoPlayerController.asset("assets/gradient.mp4")
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    currentSelectedOption = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  late VideoPlayerController _controller;
  late int currentSelectedOption;

  final TextEditingController _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _emailController = TextEditingController(),
      _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, value, child) => Scaffold(
        body: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          // color: value.currentTheme.colorScheme.surface,
          // color: Colors.black,
          color: Colors.white,
          child: Row(
            children: [
              // MARK: Graphics Section
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          // MARK: Video Player
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaY: 50,
                              sigmaX: 50,
                            ),
                            child: _controller.value.isInitialized
                                ? Transform.scale(
                                    scale: 1.2,
                                    child: VideoPlayer(_controller),
                                  )
                                : const CircularProgressIndicator(),
                          ),

                          // MARK: Front Black Sheet
                          Container(color: Colors.black.withValues(alpha: 0.5)),

                          // MARK: Graphics Content
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 0, 80, 80),
                            child: Column(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // MARK: Bottom Heading and Description
                                Row(
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Get Started with US",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 45,
                                            height: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Complete these easy steps to register your account",
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          height: 1.2,
                                          color: Colors.white.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // MARK: Current Ongoing Steps
                                Row(
                                  spacing: 20,
                                  children: [
                                    CurrentRegistrationStateWidget(
                                      index: 0,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                      description: "Sign up your account",
                                    ),
                                    CurrentRegistrationStateWidget(
                                      index: 1,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                      description: "Set up your workspace",
                                    ),
                                    CurrentRegistrationStateWidget(
                                      index: 2,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                      description: "Set up your profile",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // MARK: Content Section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // MARK: Main Heading
                      Text(
                        "Sign Up Account",
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      // MARK: Description
                      Text(
                        "Enter your personal data to create your account",
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withValues(alpha: 0.75),
                        ),
                      ),

                      // MARK: Dual Option Buttons
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            spacing: 20,
                            children: [
                              //MARK: Google Button
                              RegistrationOptionButton(
                                icon: FontAwesomeIcons.google,
                                name: "Google",
                              ),

                              // MARK: Github Button
                              RegistrationOptionButton(
                                icon: FontAwesomeIcons.facebook,
                                name: "Facebook",
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          spacing: 20,
                          children: [
                            Expanded(child: Divider()),
                            Text("Or", style: GoogleFonts.roboto(fontSize: 15)),
                            Expanded(child: Divider()),
                          ],
                        ),
                      ),

                      // MARK: First and Last Name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomInputField(
                                textController: _firstNameController,
                                labelText: "First Name",
                                placeholder: "eg. Uddeshya",
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomInputField(
                                textController: _lastNameController,
                                labelText: "Last Name",
                                placeholder: "eg. Singh",
                              ),
                            ),
                          ],
                        ),
                      ),

                      // MARK: Email Id
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                        child: CustomInputField(
                          textController: _emailController,
                          labelText: "Email Id",
                          placeholder: "eg. Uddeshya@gmail.com",
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                        child: CustomInputField(
                          textController: _phoneNumberController,
                          labelText: "Phone Number",
                          placeholder: "eg. +91 9876543211",
                        ),
                      ),

                      // MARK: Submit Form Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Row(
                          children: [
                            // MARK: Submit Button
                            Expanded(
                              child: RegistrationFormSubmitButton(
                                isEnabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black.withValues(alpha: 0.25), width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(17),
                                    child: Text(
                                      "Create Account",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
