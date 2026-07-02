import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';

class AppbarComponent extends StatefulWidget {
  final List<Widget> children;
  final bool? positioned;
  final double top;

  const AppbarComponent({super.key, required this.children, this.positioned = true, this.top = 50.0});

  @override
  State<AppbarComponent> createState() => _AppbarComponentState();
}

class _AppbarComponentState extends State<AppbarComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color borderColor = isDarkMode
        ? Colors
              .white // Subtle white border for dark mode
        : Colors.black.withAlpha(30); // Subtle dark border for light mode

    // Increased height by 10px to push contents further away from the notch
    final double appBarHeight = widget.top + 50;

    final Widget content = Container(
      height: appBarHeight,
      decoration: BoxDecoration(
        color: ColorFactory.darkForegroundColor.withAlpha(60),
        border: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: widget.children,
      ),
    );

    final Widget blurredAppBar = ClipRect(
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0), child: content),
    );

    if (widget.positioned == true) {
      return Positioned(top: 0, left: 0, right: 0, child: blurredAppBar);
    } else {
      return blurredAppBar;
    }
  }
}
