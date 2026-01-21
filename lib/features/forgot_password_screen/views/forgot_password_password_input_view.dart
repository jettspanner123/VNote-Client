import 'package:flutter/material.dart';
import 'package:vnote_client/models/validators/input_validators.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_description.dart';
import 'package:vnote_client/shared/components/page/secondary_screen_heading.dart';

class ForgotPasswordPhoneNumberInputView extends StatefulWidget {
  final TextEditingController phoneNumberController;
  const ForgotPasswordPhoneNumberInputView({super.key, required this.phoneNumberController});

  @override
  State<ForgotPasswordPhoneNumberInputView> createState() => _ForgotPasswordPhoneNumberInputViewState();
}

class _ForgotPasswordPhoneNumberInputViewState extends State<ForgotPasswordPhoneNumberInputView> {
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

          SecondaryScreenHeadingComponent(text: "Forgot Password"),
          SecondaryScreenDescriptionComponent(
            text: "Don't worry it happens. Please enter the phone number associated with your account.",
          ),

          SizedBox(height: 20),
          StandardInputField(
            icon: Icon(Icons.phone),
            placeholder: "Enter phone number.",
            textController: widget.phoneNumberController,
            validator: InputValidators.current.phoneNumberValidator,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
