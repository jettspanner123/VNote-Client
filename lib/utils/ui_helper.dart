import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_factory.dart';

class UIHelper {
  static final current = UIHelper();

  void setStatusBarColors(AppColorMode colorMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorMode == AppColorMode.DARK ? Brightness.light : Brightness.dark,
      ),
    );
  }

  TextStyle funnelTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? background,
    Paint? foreground,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return GoogleFonts.funnelSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      background: background,
      foreground: foreground,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  TextStyle newAmsterdamTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? background,
    Paint? foreground,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return GoogleFonts.newAmsterdam(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      background: background,
      foreground: foreground,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }

  Color getBackgroundColorForColorMode(AppColorMode colorMode) {
    if (colorMode == AppColorMode.DARK) return ColorFactory.darkBackgroundColor;
    return ColorFactory.backgroundColor;
  }

  Color getDefaultColorOrCustom(Color defaultColor, Color? customColor) {
    if (customColor == null) return defaultColor;
    return customColor;
  }

  Color getTextColorForColorMode(AppColorMode colorMode) {
    if (colorMode == AppColorMode.DARK) return Colors.white;
    return Colors.black;
  }

  Color getForegroundColorForColorMode(AppColorMode colorMode) {
    if (colorMode == AppColorMode.DARK) return ColorFactory.darkForegroundColor;
    return Colors.white;
  }

  T getValueAccordingToColorMode<T>({required AppColorMode colorMode, required T darkValue, required T lightValue}) {
    if (colorMode == AppColorMode.DARK) return darkValue;
    return lightValue;
  }

  BoxShadow getDefaultBoxShadow({
    Color color = Colors.black,
    double borderRadius = 10,
    Offset offset = const Offset(0, 5),
    int opacity = 10,
  }) {
    return BoxShadow(color: color.withAlpha(opacity), blurRadius: 10, offset: const Offset(0, 5));
  }

  BoxBorder getDefaultBorder({
    required AppColorMode colorMode,
    Color lightColor = Colors.black,
    Color darkColor = Colors.white,
    double width = 1,
    int opacity = 50,
  }) {
    if (colorMode == AppColorMode.DARK) return Border.all(color: darkColor.withAlpha(opacity), width: width);
    return Border.all(color: lightColor.withAlpha(opacity), width: width);
  }

  void scrollDownToKey(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 500));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(key.currentContext!, duration: const Duration(milliseconds: 150));
    });
  }
}
