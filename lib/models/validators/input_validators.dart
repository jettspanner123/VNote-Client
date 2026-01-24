import 'package:flutter/material.dart';

class InputValidators {
  static final current = InputValidators();

  List<String> specialCharacters = ["@", "#", "-", "_", "!", "%"];
  String? phoneNumberValidator(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) return "Please Enter Phone Number";
    if (!RegExp(r'^\d{10}$').hasMatch(text)) return "Enter a valida 10-digit number";

    return null;
  }

  String? emailValidator(String? value) {
    final email = value?.trim() ?? "";

    if (email.isEmpty) return "Email is required";

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
      r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
      r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailRegex.hasMatch(email)) return "Enter a valid email";

    return null; // ✅ valid
  }

  String? otpValidator(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Enter A Valid Number";
    if (int.tryParse(text) == null) return "Enter A Valid Number";
    return null;
  }

  String? passwordValidator(String? value, TextEditingController? other) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Password must be atleast 8 characters long.";
    if (text.length > 16) return "Password cannot be more then 16 characters.";
    if (!specialCharacters.any((ch) => text.contains(ch))) return "Please add one of these [ @, #, -, _, !, %]";

    if (other != null) {
      if (value != other.text) return "Passwords do not match.";
    }

    return null;
  }

  String? fullNameValidator(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "Name cannot be empty";
    if (text.length < 2) return "Name must be of atleast 2 characters.";
    return null;
  }
}
