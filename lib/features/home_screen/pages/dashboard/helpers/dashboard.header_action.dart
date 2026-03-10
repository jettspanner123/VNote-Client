import 'package:flutter/material.dart';

class DashboardHeaderAction {
  final String title;
  final String iconImage;
  final Color accentColor;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const DashboardHeaderAction({
    required this.title,
    required this.iconImage,
    required this.accentColor,
    required this.padding,
    this.onTap,
  });
}
