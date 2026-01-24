import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';

class QuestionareBasicDetailsView extends StatefulWidget {
  const QuestionareBasicDetailsView({super.key});

  @override
  State<QuestionareBasicDetailsView> createState() => _QuestionareBasicDetailsViewState();
}

class _QuestionareBasicDetailsViewState extends State<QuestionareBasicDetailsView> {
  final _fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: ListView(
          children: [
            QuestionareTopSpaceHeight,
            QuestionareProgressIndicatorComponent(currentScreen: 0),
            QuestionareTopSpaceHeight,
            QuestionareHeadingComponent(text: "Kindly enter some of your personal details."),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "This helps us personalize your experience and keep everything accurate.",
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Full Name"),
            StandardInputField(textController: _fullNameController, icon: Icon(Icons.person)),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Email Address", secondaryText: "(Optional)"),
            StandardInputField(textController: _fullNameController, icon: Icon(Icons.email)),
          ],
        ),
      ),
    );
  }
}
