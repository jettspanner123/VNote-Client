import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';

enum QuesitonareTypeOfUser { personal, business, none }

class QuesitonareTypeOfUserView extends StatefulWidget {
  const QuesitonareTypeOfUserView({super.key});

  @override
  State<QuesitonareTypeOfUserView> createState() => _QuesitonareTypeOfUserViewState();
}

class _QuesitonareTypeOfUserViewState extends State<QuesitonareTypeOfUserView> {
  QuesitonareTypeOfUser _currentSelected = QuesitonareTypeOfUser.personal;
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
            QuestionareHeadingComponent(text: "Buisness Owner or Personal Use?"),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "Are you willing to the app for your business or your personal perpouses?",
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Choose One"),

            MultipleChoiceController<QuesitonareTypeOfUser>(
              currentSelected: _currentSelected,
              children: [
                MultipleChoiceOption(
                  value: QuesitonareTypeOfUser.personal,
                  image: "assets/images/questionare_image/individual_user.png",
                  title: "Personal Tracking",
                  description: "Track your income and spending to manage your daily finances easily.",
                ),
                MultipleChoiceOption(
                  value: QuesitonareTypeOfUser.business,
                  image: "assets/images/questionare_image/buisness_owner.png",
                  title: "Business Tracking",
                  description: "Monitor business income and expenses to stay on top of transactions.",
                ),
              ],
              onSelectionChange: (data) {
                setState(() {
                  _currentSelected = data.value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
