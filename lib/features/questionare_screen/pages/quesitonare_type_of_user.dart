import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';

class QuesitonareTypeOfUserView extends StatefulWidget {
  const QuesitonareTypeOfUserView({super.key});

  @override
  State<QuesitonareTypeOfUserView> createState() => _QuesitonareTypeOfUserViewState();
}

class _QuesitonareTypeOfUserViewState extends State<QuesitonareTypeOfUserView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: ListView(
          children: [
            QuestionareTopSpaceHeight,
            QuestionareProgressIndicatorComponent(currentScreen: 1),
            QuestionareTopSpaceHeight,
            QuestionareHeadingComponent(text: "Buisness Owner or only for Personal Use?"),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "Are you willing to the app for your business or your personal perpouses?",
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Choose One"),
          ],
        ),
      ),
    );
  }
}
