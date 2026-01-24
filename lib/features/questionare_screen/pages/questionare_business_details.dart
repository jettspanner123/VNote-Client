import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';

class QuestionareBusinessDetailsView extends StatefulWidget {
  const QuestionareBusinessDetailsView({super.key});

  @override
  State<QuestionareBusinessDetailsView> createState() => _QuestionareBusinessDetailsViewState();
}

class _QuestionareBusinessDetailsViewState extends State<QuestionareBusinessDetailsView> {
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
            QuestionareHeadingComponent(text: "Tell us about your business."),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "Please help us understand more about your business for personalized experience.",
            ),
          ],
        ),
      ),
    );
  }
}
