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
import 'package:vnote_client/utils/keyboard_helper.dart';

const QuestionareTopSpaceHeight = SizedBox(height: 30);
const QuestionareSpacerHeight = SizedBox(height: 20);

final _questionareBasicQuestionsFormKey = GlobalKey<FormState>();
final _questionareUserTypeFormKey = GlobalKey<FormState>();
final _questionareBusinessQuestionsFormKey = GlobalKey<FormState>();

enum QuestionareScreenOptions { basicQuestions, typeOfUser, buisnessQuestions }

class QuestionareControllerScreen extends StatefulWidget {
  const QuestionareControllerScreen({super.key});

  @override
  State<QuestionareControllerScreen> createState() => _QuestionareControllerScreenState();
}

class _QuestionareControllerScreenState extends State<QuestionareControllerScreen> {
  final questionareServices = QuestionareServices();
  QuestionareScreenOptions _currentScreen = QuestionareScreenOptions.typeOfUser;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();

  void _handlePrimaryButtonTap() {
    final data = questionareServices.handlePrimaryButtonTap(
      context,
      _currentScreen,
      _questionareBasicQuestionsFormKey,
      _questionareUserTypeFormKey,
      _questionareBusinessQuestionsFormKey,
    );

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
    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom > 200;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _currentScreen == QuestionareScreenOptions.basicQuestions
            ? Form(
                key: _questionareBasicQuestionsFormKey,
                child: QuestionareBasicDetailsView(
                  key: ValueKey(QuestionareScreenOptions.basicQuestions.toString()),
                  fullNameController: _fullNameController,
                  emailController: _emailController,
                ),
              )
            : _currentScreen == QuestionareScreenOptions.typeOfUser
            ? Form(
                key: _questionareUserTypeFormKey,
                child: QuesitonareTypeOfUserView(key: ValueKey(QuestionareScreenOptions.typeOfUser.toString())),
              )
            : Form(
                key: _questionareBusinessQuestionsFormKey,
                child: QuestionareBusinessDetailsView(
                  key: ValueKey(QuestionareScreenOptions.buisnessQuestions.toString()),
                ),
              ),
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
            if (isKeyboardUp) ...[
              GhostButtonComponent(
                onTap: () {
                  KeyboardHelper.current.dismissKeyboad(context);
                },
                child: StandardButtonPadding(child: Icon(Icons.close)),
              ),
            ],
            Expanded(
              flex: 1,
              child: StandardButtonComponent(
                onTap: _handlePrimaryButtonTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StandardButtonText(
                      text: isKeyboardUp
                          ? _currentScreen == QuestionareScreenOptions.basicQuestions
                                ? "Next Question"
                                : "Next"
                          : "Next Question",
                    ),
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
