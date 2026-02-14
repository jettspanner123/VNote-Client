import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/extensions/string_extensions.dart';
import 'package:vnote_client/features/language_selector_screen/language.controller.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LanguageOption extends StatefulWidget {
  final Language selectedLanguage;
  final (Language name, String image) language;
  final VoidCallback onTap;
  const LanguageOption({super.key, required this.selectedLanguage, required this.language, required this.onTap});

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (isTapped) return;
        setState(() {
          isTapped = true;
        });
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) {
        if (!isTapped) return;
        setState(() {
          isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        if (!isTapped) return;
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: isTapped ? 0.95 : 1,
        duration: 100.milliseconds,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.selectedLanguage == widget.language.$1
                ? ColorFactory.accentColor.withAlpha(20)
                : isTapped
                ? ColorFactory.accentColor.withAlpha(10)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: BoxBorder.all(
              color: widget.selectedLanguage == widget.language.$1
                  ? ColorFactory.accentColor
                  : Colors.black.withAlpha(90),
              width: widget.selectedLanguage == widget.language.$1 ? 1 : 0.3,
            ),
          ),
          child: Column(
            spacing: 10,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(widget.language.$2, height: 20),
                  ),
                ),
              ),
              Text(
                getLanguageName(widget.language.$1),
                style: UIHelper.current.funnelTextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
