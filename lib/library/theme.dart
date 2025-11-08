import "package:client/constants/application_colors.dart";
import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: ApplicationColors.primaryLightBackground,
    primary: Colors.black,
    secondary: ApplicationColors.primaryAccent,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: ApplicationColors.primaryDarkBackground,
    primary: Colors.white,
    secondary: ApplicationColors.primaryAccent,
  ),
);
