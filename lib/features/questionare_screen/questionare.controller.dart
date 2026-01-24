import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vnote_client/features/questionare_screen/pages/quesitonare_type_of_user.dart';
import 'package:vnote_client/features/questionare_screen/pages/questionare_basic_details.dart';
import 'package:vnote_client/features/questionare_screen/pages/questionare_business_details.dart';
import 'package:vnote_client/features/questionare_screen/questionare.services.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/ghost_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';

const QuestionareTopSpaceHeight = SizedBox(height: 30);
const QuestionareSpacerHeight = SizedBox(height: 20);

enum QuestionareScreenOptions { basicQuestions, typeOfUser, buisnessQuestions }

class QuestionareControllerScreen extends StatefulWidget {
  const QuestionareControllerScreen({super.key});

  @override
  State<QuestionareControllerScreen> createState() => _QuestionareControllerScreenState();
}

class _QuestionareControllerScreenState extends State<QuestionareControllerScreen> {
  final questionareServices = QuestionareServices();
  QuestionareScreenOptions _currentScreen = QuestionareScreenOptions.basicQuestions;

  void _handlePrimaryButtonTap() {
    final data = questionareServices.handlePrimaryButtonTap(_currentScreen);
    if (data != null) {
      setState(() {
        _currentScreen = data;
      });
    }
  }

  void _handleSecondaryButtonTap() {
    final data = questionareServices.handleSecondaryButtonTap(_currentScreen);
    if (data != null) {
      setState(() {
        _currentScreen = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _currentScreen == QuestionareScreenOptions.basicQuestions
            ? QuestionareBasicDetailsView(key: ValueKey(QuestionareScreenOptions.basicQuestions.toString()))
            : _currentScreen == QuestionareScreenOptions.typeOfUser
            ? QuesitonareTypeOfUserView(key: ValueKey(QuestionareScreenOptions.typeOfUser.toString()))
            : QuestionareBusinessDetailsView(key: ValueKey(QuestionareScreenOptions.buisnessQuestions.toString())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: Row(
          spacing: 10,
          children: [
            if (_currentScreen != QuestionareScreenOptions.basicQuestions) ...[
              GhostButtonComponent(
                onTap: _handleSecondaryButtonTap,
                child: StandardButtonPadding(child: Icon(Icons.chevron_left)),
              ),
            ],
            Expanded(
              flex: 1,
              child: StandardButtonComponent(
                onTap: _handlePrimaryButtonTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StandardButtonText(text: "Next Question"),
                    Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
