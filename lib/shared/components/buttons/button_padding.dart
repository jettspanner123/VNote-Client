import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';

class StandardButtonPadding extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry padding;
  const StandardButtonPadding({
    super.key,
    required this.child,
    this.padding = ComponentConstants.standardButtonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
