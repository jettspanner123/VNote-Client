import 'package:flutter/material.dart';
import 'package:vnote_client/shared/components/inputs/otp_input_field.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class ForgotPasswordOtpInputView extends StatefulWidget {
  final TextEditingController otpController;
  const ForgotPasswordOtpInputView({super.key, required this.otpController});

  @override
  State<ForgotPasswordOtpInputView> createState() => ForgotPasswordOtpInputViewState();
}

class ForgotPasswordOtpInputViewState extends State<ForgotPasswordOtpInputView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ApplicationBarBackButtonComponent()],
            ),
          ),

          SecondaryScreenHeadingComponent(text: "Enter OTP"),
          SecondaryScreenDescriptionComponent(
            text: "An one-time-password is sent to your regestered phone number, please enter that.",
          ),

          SizedBox(height: 20),
          Row(
            spacing: 10,
            children: [
              OtpInputField(textEditingController: widget.otpController, autoFocus: true),
              OtpInputField(textEditingController: widget.otpController),
              OtpInputField(textEditingController: widget.otpController),
              OtpInputField(
                wantNextFocus: false,
                textEditingController: widget.otpController,
                onChange: (value) {
                  if (value.length == 1) {
                    KeyboardHelper.current.dismissKeyboad(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
