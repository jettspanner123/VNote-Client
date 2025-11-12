import "package:client/components/static/registration_option_button.dart";
import "package:client/pages/registration_screen.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";

import "../shared/custom_button.dart";
import "../shared/custom_text_field.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _emailController = TextEditingController(),
      _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                      },
                      backgroundColor: Colors.black,
                      isEnabled: false,
                      buttonType: CustomButtons.normal,
                      disableOpacity: 0.3,
                      content: Text(
                        "Submit",
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
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
                    child: CustomButton(
                      onTap: () {},
                      buttonType: CustomButtons.outline,
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      content: Text("Create Account"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
