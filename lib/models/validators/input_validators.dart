class InputValidators {
  static final current = InputValidators();
  String? phoneNumberValidator(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) return "Please Enter Phone Number";
    if (!RegExp(r'^\d{10}$').hasMatch(text)) return "Enter a valida 10-digit number";

    return null;
  }
}
