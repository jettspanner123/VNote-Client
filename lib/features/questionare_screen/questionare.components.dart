import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/utils/ui_helper.dart';

// MARK: Page Heading Component
class QuestionareHeadingComponent extends StatelessWidget {
  final String text;
  const QuestionareHeadingComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: UIHelper.current.funnelTextStyle(fontSize: 35, fontWeight: FontWeight.bold, height: 1));
  }
}

// MARK: Page Description Component
class QuestionareDescriptionComponent extends StatelessWidget {
  final String text;
  const QuestionareDescriptionComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: UIHelper.current.funnelTextStyle(fontSize: 15));
  }
}

// MARK: Page Progress Indicator
class QuestionareProgressIndicatorComponent extends StatefulWidget {
  final int currentScreen;
  const QuestionareProgressIndicatorComponent({super.key, required this.currentScreen});

  @override
  State<QuestionareProgressIndicatorComponent> createState() => _QuestionareProgressIndicatorComponentState();
}

class _QuestionareProgressIndicatorComponentState extends State<QuestionareProgressIndicatorComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 0 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 1 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 2 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
