import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';

class FloatingButtonHolderComponent extends StatelessWidget {
  final Widget child;
  const FloatingButtonHolderComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ComponentConstants.screenHorizontalPadding,
      child: SizedBox(width: double.infinity, child: child),
    );
  }
}
