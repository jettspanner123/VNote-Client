import 'package:flutter/material.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class QuestionareServices {
  QuestionareScreenOptions? handlePrimaryButtonTap(
    BuildContext context,
    QuestionareScreenOptions currentScreen,
    GlobalKey<FormState> basicQuestionFormKey,
    GlobalKey<FormState> userTypeFormKey,
    GlobalKey<FormState> businessQuestionsFormKey,
  ) {
    switch (currentScreen) {
      case QuestionareScreenOptions.basicQuestions:
        if (basicQuestionFormKey.currentState?.validate() ?? false) {
          KeyboardHelper.current.dismissKeyboad(context);
          return QuestionareScreenOptions.typeOfUser;
        }
      case QuestionareScreenOptions.typeOfUser:
        return QuestionareScreenOptions.buisnessQuestions;
      case QuestionareScreenOptions.buisnessQuestions:
        return null;
    }
  }

  QuestionareScreenOptions? handleSecondaryButtonTap(QuestionareScreenOptions currentScreen) {
    switch (currentScreen) {
      case QuestionareScreenOptions.basicQuestions:
        return null;
      case QuestionareScreenOptions.typeOfUser:
        return QuestionareScreenOptions.basicQuestions;
      case QuestionareScreenOptions.buisnessQuestions:
        return QuestionareScreenOptions.typeOfUser;
    }
  }
}
