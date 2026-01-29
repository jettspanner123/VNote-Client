import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/models/api/base_response.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class RegistrationService {
  Future<void> registerAccount({
    required GlobalKey<FormState> formState,
    required BuildContext context,
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
  }) async {
    // if (formState.currentState?.validate() ?? false) {
    //   KeyboardHelper.current.dismissKeyboad(context);

    // Api Call
    final data = await _RegistrationHelperService.createUser(
      fullName: fullNameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
    );

    print(data);

    //   // Move To Next Page
    //   Navigator.pushNamed(context, NavigationFactory.registrationOtpScreen);
    // }
  }
}

class _RegistrationHelperService {
  static Future<BaseResponse?> createUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await HTTP.get(Uri.parse("http://172.20.10.1:8080/api/user/health"));

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    }
  }
}
