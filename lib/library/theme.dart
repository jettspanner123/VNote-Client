import "package:client/constants/application_colors.dart";
import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: ApplicationColors.primaryLightBackground,
  ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: ApplicationColors.primaryDarkBackground,
  ),
);
