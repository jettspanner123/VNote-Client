import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/inputs/otp_input_field.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';
import 'package:vnote_client/shared/views/secondary_page_container.dart';
import 'package:vnote_client/shared/views/submit_button_with_dismiss_keyboard_button.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationOtpView extends StatefulWidget {
  const RegistrationOtpView({super.key});

  @override
  State<RegistrationOtpView> createState() => _RegistrationOtpViewState();
}

class _RegistrationOtpViewState extends State<RegistrationOtpView> {
  final _otpFirstController = TextEditingController();
  final _otpSecondController = TextEditingController();
  final _otpThirdController = TextEditingController();
  final _otpFourthController = TextEditingController();

  String finalOtp = "";

  void updateOtpAndDismiss() {
    finalOtp =
        _otpFirstController.text + _otpSecondController.text + _otpThirdController.text + _otpFourthController.text;

    if (finalOtp.length == 4) {
      KeyboardHelper.current.dismissKeyboad(context);
    }
  }

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
                SizedBox(height: 20),
                Row(
                  spacing: 10,
                  children: [
                    OtpInputField(
                      onChange: (_) => updateOtpAndDismiss(),
                      textEditingController: _otpFirstController,
                      autoFocus: true,
                    ),
                    OtpInputField(onChange: (_) => updateOtpAndDismiss(), textEditingController: _otpSecondController),
                    OtpInputField(onChange: (_) => updateOtpAndDismiss(), textEditingController: _otpThirdController),
                    OtpInputField(onChange: (_) => updateOtpAndDismiss(), textEditingController: _otpFourthController),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: FloatingButtonHolderComponent(
          child: StandardButtonWithDismissKeyboardComponent(child: StandardButtonText(text: "Continue")),
        ),
      ),
    );
  }
}
