import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnote_client/features/forgot_password_screen/forgot_password.services.dart';
import 'package:vnote_client/models/validators/input_validators.dart';
import 'package:vnote_client/shared/components/inputs/otp_input_field.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class ForgotPasswordOtpInputView extends StatefulWidget {
  final TextEditingController otpController;
  final VoidCallback? onInputFocus;
  const ForgotPasswordOtpInputView({super.key, required this.otpController, this.onInputFocus});

  @override
  State<ForgotPasswordOtpInputView> createState() => ForgotPasswordOtpInputViewState();
}

class ForgotPasswordOtpInputViewState extends State<ForgotPasswordOtpInputView> {
  final _forgetPasswordService = ForgotPasswordServices();
  int timerSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timerSeconds = 30;

    timer = Timer.periodic(const Duration(seconds: 1), (time) {
      if (timerSeconds == 0) {
        time.cancel();
      } else {
        setState(() {
          timerSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
              OtpInputField(
                onFocus: widget.onInputFocus,
                textEditingController: widget.otpController,
                autoFocus: true,
                validator: InputValidators.current.otpValidator,
              ),
              OtpInputField(
                textEditingController: widget.otpController,
                validator: InputValidators.current.otpValidator,
              ),
              OtpInputField(
                textEditingController: widget.otpController,
                validator: InputValidators.current.otpValidator,
              ),
              OtpInputField(
                wantNextFocus: false,
                textEditingController: widget.otpController,
                validator: InputValidators.current.otpValidator,
                onChange: (value) {
                  if (value.length == 1) {
                    KeyboardHelper.current.dismissKeyboad(context);
                  }
                },
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Didn't get a code?", style: UIHelper.current.funnelTextStyle()),
              GestureDetector(
                onTap: () {
                  if (timerSeconds == 0) {
                    HapticFeedback.lightImpact();
                    _forgetPasswordService.resendOtp();
                    _startTimer();
                  }
                },
                child: Opacity(
                  opacity: timerSeconds == 0 ? 1 : 0.5,
                  child: Text(
                    timerSeconds == 0 ? "Resend" : "Resend in ${timerSeconds}s",
                    style: UIHelper.current.funnelTextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 200),
        ],
      ),
    );
  }
}
