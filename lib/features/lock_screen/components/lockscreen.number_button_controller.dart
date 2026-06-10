import 'package:flutter/material.dart';
import 'package:vnote_client/features/lock_screen/components/lockscreen.number_button_component.dart';
import 'package:vnote_client/features/lock_screen/constants/lockscreen.constants.dart';

class LockScreenNumberButtonController extends StatelessWidget {
  final void Function(String value) onButtonTap;

  const LockScreenNumberButtonController({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: LockScreenConstants.current.NUMBER_BUTTONS.map((value) {
        return LockScreenNumberButtonComponent(value: value, onTap: () => onButtonTap(value));
      }).toList(),
    );
  }
}
