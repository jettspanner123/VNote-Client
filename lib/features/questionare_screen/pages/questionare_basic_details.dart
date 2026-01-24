import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/models/validators/input_validators.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';

class QuestionareBasicDetailsView extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  const QuestionareBasicDetailsView({super.key, required this.fullNameController, required this.emailController});

  @override
  State<QuestionareBasicDetailsView> createState() => _QuestionareBasicDetailsViewState();
}

class _QuestionareBasicDetailsViewState extends State<QuestionareBasicDetailsView> {
  final _fullNameController = TextEditingController();
  final _scrollController = ScrollController();

  void _handleOnKeyboardOpen() {
    _scrollController.animateTo(
      100,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: ComponentConstants.screenHorizontalPadding,
        child: ListView(
          controller: _scrollController,
          children: [
            QuestionareTopSpaceHeight,
            QuestionareProgressIndicatorComponent(currentScreen: 0),
            QuestionareTopSpaceHeight,
            QuestionareHeadingComponent(text: "Enter your personal details."),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "This helps us personalize your experience and keep everything accurate.",
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Full Name"),
            StandardInputField(
              placeholder: "Vanshika Garg",
              textController: _fullNameController,
              icon: Icon(Icons.person),
              onFocus: _handleOnKeyboardOpen,
              validator: InputValidators.current.fullNameValidator,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
              keyboardType: TextInputType.name,
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Email Address", secondaryText: "(Optional)"),
            StandardInputField(
              placeholder: "vanshika@gmail.com",
              textController: _fullNameController,
              icon: Icon(Icons.email),
              onFocus: _handleOnKeyboardOpen,
              keyboardType: TextInputType.emailAddress,
              validator: InputValidators.current.emailValidator,
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
