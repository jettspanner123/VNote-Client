import 'package:flutter/material.dart';

class KeyboardHelper {
  static final current = KeyboardHelper();

  void dismissKeyboad(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
}
