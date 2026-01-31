import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class RegistrationWelcomeController extends StatefulWidget {
  const RegistrationWelcomeController({super.key});

  @override
  State<RegistrationWelcomeController> createState() => _RegistrationWelcomeControllerState();
}

class _RegistrationWelcomeControllerState extends State<RegistrationWelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: ComponentConstants.screenHorizontalPadding,
          child: Column(
            children: [
              QuestionareTopSpaceHeight,
              Text(
                "A Few Questions to Personalize Your Experience",
                style: UIHelper.current.funnelTextStyle(fontSize: 35, fontWeight: FontWeight.bold, height: 1.05),
              ),
              QuestionareTopSpaceHeight,
              Container(
                width: double.infinity,
                color: Colors.blue,
                child: Image.asset("assets/images/others/questionare.png", fit: BoxFit.cover),
              ),
              QuestionareTopSpaceHeight,
              Text(
                "Answer a few quick questions so we can tailor features, content, and recommendations just for you. This will only take a minute.",
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withAlpha(110),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              SizedBox(
                width: double.infinity,
                child: StandardButtonComponent(child: StandardButtonText(text: "Take Questionnaire")),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButtonComponent(
                  child: StandardButtonText(text: "Maybe Later", foregroundColor: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
