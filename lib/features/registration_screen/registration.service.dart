import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/constants/network_constants.dart';
import 'package:vnote_client/models/api/dto/auth_register_dto.dart';
import 'package:vnote_client/services/network_service.dart';
import 'package:vnote_client/utils/api_helper.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationService {
    Future<void> registerAccount({
        required GlobalKey<FormState> formState,
        required BuildContext context,
        required TextEditingController fullNameController,
        required TextEditingController emailController,
        required TextEditingController phoneNumberController,
        required TextEditingController passwordController,
        required Function(String) onError,
    }) async {
        if (formState.currentState?.validate() ?? false) {
            KeyboardHelper.current.dismissKeyboad(context);
            final fullNameParts = fullNameController.text.trim().split(" ");
            final firstName = fullNameParts.first;
            final lastName = fullNameParts.length > 1 ? fullNameParts.last : null;

            final data = await NetworkService.current.post.auth.registerUser(
                AuthRegisterDTO(
                    firstName: firstName,
                    lastName: lastName,
                    email: emailController.text,
                    phoneNumber: "+91-${phoneNumberController.text}",
                    role: UserRole.admin, language: UserLanguage.english,
                    password: passwordController.text
                )
            );

            if (data == null) {
                onError("Something Went Wrong! Please try again.");
                return;
            }
            if (data.success) {
                await Future.delayed(500.milliseconds, () {
                        Navigator.pushNamed(context, NavigationFactory.registrationOtpScreen);
                    }
                );
            }
            else {
                onError(data.message);
            }
        }
    }
}
