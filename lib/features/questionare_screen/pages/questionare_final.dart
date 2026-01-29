import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class QuestionareFinalView extends StatefulWidget {
  const QuestionareFinalView({super.key});

  @override
  State<QuestionareFinalView> createState() => _QuestionareFinalViewState();
}

class _QuestionareFinalViewState extends State<QuestionareFinalView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: ListView(
          children: [
            QuestionareTopSpaceHeight,
            QuestionareProgressIndicatorComponent(currentScreen: 2),
            QuestionareTopSpaceHeight,
            QuestionareHeadingComponent(text: "Thank you for your time"),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text:
                  "Your questionnaire is complete, and your account is all set up — feel free to start using the app!",
            ),
            QuestionareSpacerHeight,
            Text(
              "Make sure the details you’ve provided are accurate — you can always edit them later.",
              style: UIHelper.current.funnelTextStyle(fontSize: 15, color: Colors.red),
            ),
            QuestionareSpacerHeight,
            QuestionareSpacerHeight,
            Image.asset("assets/images/questionare_image/questionare_completed.png"),
          ],
        ),
      ),
    );
  }
}
