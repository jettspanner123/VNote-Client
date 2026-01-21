import 'package:flutter/material.dart';

class ComponentConstants {
  // Buttons
  static const EdgeInsetsGeometry standardButtonPadding = EdgeInsetsGeometry.symmetric(
    horizontal: 30.0,
    vertical: 15.0,
  );
  static const double standardButtonVerticalPadding = 15.0;

  // Text Sizes
  static const double standardButtonFontSize = 15.0;

  // Screen
  static const EdgeInsetsGeometry screenHorizontalPadding = EdgeInsets.symmetric(horizontal: 20.0);
  static const EdgeInsetsGeometry secondaryScreenAppBarTopPadding = EdgeInsetsGeometry.only(
    top: ComponentConstants.secondaryScreenAppBarHeight + 25,
    bottom: 25,
  );
  static const double secondaryScreenAppBarHeight = 95;
}
