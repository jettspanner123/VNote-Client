import 'package:flutter/material.dart';
import 'package:vnote_client/features/questionare_screen/pages/quesitonare_type_of_user.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class QuestionareServices {
  QuestionareScreenOptions? handlePrimaryButtonTap(
    BuildContext context,
    QuestionareScreenOptions currentScreen,
    QuesitonareTypeOfUser currentTypeOfUser,
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
        if (currentTypeOfUser != QuesitonareTypeOfUser.none) {}
        return QuestionareScreenOptions.buisnessQuestions;
      case QuestionareScreenOptions.buisnessQuestions:
        if (businessQuestionsFormKey.currentState?.validate() ?? false) {
          KeyboardHelper.current.dismissKeyboad(context);
          return QuestionareScreenOptions.finalPage;
        }
      case QuestionareScreenOptions.finalPage:
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
      case QuestionareScreenOptions.finalPage:
        return QuestionareScreenOptions.buisnessQuestions;
    }
  }
}
