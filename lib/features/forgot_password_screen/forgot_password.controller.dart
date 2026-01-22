import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/forgot_password_screen/forgot_password.services.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_otp_input_view.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_password_input_view.dart';
import 'package:vnote_client/features/forgot_password_screen/views/forgot_password_reset_password_input_view.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/views/submit_button_with_dismiss_keyboard_button.dart';

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
  final forgotPasswordServices = ForgotPasswordServices();

  ForgotPasswordScreenOptions _currentScreen = ForgotPasswordScreenOptions.phoneNumberInput;

  final _scrollController = ScrollController();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _resetPasswordController = TextEditingController();
  final _resetConfirmPasswordController = TextEditingController();

  // Handle Submit Button Action  {#117,51}
  void _handlePrimaryButtonAction() async {
    final data = await forgotPasswordServices.handlePrimaryButtonAction(
      context,
      _currentScreen,
      _forgotPasswordFormKey,
      _forgotPasswordOtpFormKey,
    );

    if (data != null) {
      setState(() {
        _currentScreen = data;
      });
    }
  }

  // Handle Cancel Button Action  {#1fb,20}
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

  // Scroll Down On Input Focus {#89f,11}
  void _handleOnInputFocusScrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
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
                    child: ForgotPasswordPhoneNumberInputView(phoneNumberController: _phoneNumberController),
                  )
                : _currentScreen == ForgotPasswordScreenOptions.otpInput
                ? Form(
                    key: _forgotPasswordOtpFormKey,
                    child: ForgotPasswordOtpInputView(
                      key: ValueKey(ForgotPasswordScreenOptions.otpInput.toString()),
                      otpController: _otpController,
                      onInputFocus: _handleOnInputFocusScrollDown,
                    ),
                  )
                : Form(
                    key: _forogtPasswordResetPasswordFormKey,
                    child: ForgotPasswordResetPasswordInputView(
                      key: ValueKey(ForgotPasswordScreenOptions.resetPasswordInput.toString()),
                      resetConfirmPasswordController: _resetConfirmPasswordController,
                      resetPasswordController: _resetPasswordController,
                      onInputFocus: _handleOnInputFocusScrollDown,
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
