import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';
import 'package:vnote_client/shared/views/secondary_page_container.dart';

class RegistrationOtpView extends StatefulWidget {
  const RegistrationOtpView({super.key});

  @override
  State<RegistrationOtpView> createState() => _RegistrationOtpViewState();
}

class _RegistrationOtpViewState extends State<RegistrationOtpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: ComponentConstants.screenHorizontalPadding,
          children: [
            QuestionareSpacerHeight,
            SecondaryScreenContainerComponent(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(children: [ApplicationBarBackButtonComponent()]),
                ),

                SecondaryScreenHeadingComponent(text: "Enter Otp"),
                SecondaryScreenDescriptionComponent(
                  text: "Enter the one-time password sent to your registered mobile number.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
