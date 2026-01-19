import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';

class StandardButtonPadding extends StatelessWidget {
  final Widget? child;
  const StandardButtonPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: ComponentConstants.standardButtonPadding, child: child);
  }
}
