import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_otp_input_view.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_password_input_view.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_reset_password_input_view.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/views/submit_button_with_dismiss_keyboard_button.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

final _forgotPasswordFormKey = GlobalKey<FormState>();
final _forgotPasswordOtpFormKey = GlobalKey<FormState>();
final _forogtPasswordResetPasswordFormKey = GlobalKey<FormState>();

enum ForgotPasswordScreenOptions { phoneNumberInput, otpInput, resetPasswordInput }

class ForgotPasswordControllerScreen extends StatefulWidget {
  const ForgotPasswordControllerScreen({super.key});

  @override
  State<ForgotPasswordControllerScreen> createState() => _ForgotPasswordControllerScreenState();
}

class _ForgotPasswordControllerScreenState extends State<ForgotPasswordControllerScreen> {
  ForgotPasswordScreenOptions _currentScreen = ForgotPasswordScreenOptions.otpInput;

  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _resetPasswordController = TextEditingController();
  final _resetConfirmPasswordController = TextEditingController();

  // MARK: Submit button action
  void _handlePrimaryButtonAction() async {
    if (_currentScreen == ForgotPasswordScreenOptions.phoneNumberInput) {
      if (_forgotPasswordFormKey.currentState!.validate()) {
        KeyboardHelper.current.dismissKeyboad(context);
        await Future.delayed(const Duration(milliseconds: 500));

        // TODO: Check if phone number exists in the database.

        // TODO: Send otp to the phone number.

        setState(() {
          _currentScreen = ForgotPasswordScreenOptions.otpInput;
        });
      }
    } else if (_currentScreen == ForgotPasswordScreenOptions.otpInput) {
      if (_forgotPasswordOtpFormKey.currentState!.validate()) {
        KeyboardHelper.current.dismissKeyboad(context);
        await Future.delayed(const Duration(milliseconds: 500));

        // TODO: Check if the otp is correct

        setState(() {
          _currentScreen = ForgotPasswordScreenOptions.resetPasswordInput;
        });
      }
    } else {
      if (_forogtPasswordResetPasswordFormKey.currentState!.validate()) {}
    }
  }

  // MARK: Cancel Button Action
  void _handleSecondaryButtonAction() async {
    switch (_currentScreen) {
      case ForgotPasswordScreenOptions.phoneNumberInput:
        break;
      case ForgotPasswordScreenOptions.otpInput:
        _otpController.clear();
        setState(() {
          _currentScreen = ForgotPasswordScreenOptions.phoneNumberInput;
        });
        break;
      case ForgotPasswordScreenOptions.resetPasswordInput:
        _resetPasswordController.clear();
        _resetConfirmPasswordController.clear();
        _otpController.clear();
        setState(() {
          _currentScreen = ForgotPasswordScreenOptions.phoneNumberInput;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(children: [...previousChildren, if (currentChild != null) currentChild]);
            },
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut),
                child: child,
              );
            },
            child: _currentScreen == ForgotPasswordScreenOptions.phoneNumberInput
                ? Form(
                    key: _forgotPasswordFormKey,
                    child: ForgotPasswordPhoneNumberInputView(
                      key: ValueKey(ForgotPasswordScreenOptions.phoneNumberInput.toString()),
                      phoneNumberController: _phoneNumberController,
                    ),
                  )
                : _currentScreen == ForgotPasswordScreenOptions.otpInput
                ? Form(
                    key: _forgotPasswordOtpFormKey,
                    child: ForgotPasswordOtpInputView(
                      key: ValueKey(ForgotPasswordScreenOptions.otpInput.toString()),
                      otpController: _otpController,
                    ),
                  )
                : Form(
                    key: _forogtPasswordResetPasswordFormKey,
                    child: ForgotPasswordResetPasswordInputView(
                      key: ValueKey(ForgotPasswordScreenOptions.resetPasswordInput.toString()),
                      resetConfirmPasswordController: _resetConfirmPasswordController,
                      resetPasswordController: _resetPasswordController,
                    ),
                  ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: StandardButtonWithDismissKeyboardComponent(
          onTap: _handlePrimaryButtonAction,
          secondaryButtonChild: _currentScreen != ForgotPasswordScreenOptions.phoneNumberInput
              ? StandardButtonText(text: "Cancel", foregroundColor: Colors.black)
              : null,
          secondaryOnTap: _handleSecondaryButtonAction,
          child: StandardButtonText(text: "Proceed"),
        ),
      ),
    );
  }
}
