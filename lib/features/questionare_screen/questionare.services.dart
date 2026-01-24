import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';

class QuestionareServices {
  QuestionareScreenOptions? handlePrimaryButtonTap(QuestionareScreenOptions currentScreen) {
    switch (currentScreen) {
      case QuestionareScreenOptions.basicQuestions:
        return QuestionareScreenOptions.typeOfUser;
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
