import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
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
      // spacing: 10,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 0 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 1 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              // borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.currentScreen >= 2 ? ColorFactory.accentColor : Colors.black.withAlpha(20),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }
}

// Options Selection View
class MultipleChoiceOption<MultipleChoiseOptionType> {
  final MultipleChoiseOptionType value;
  final String image;
  final String title;
  final String description;

  MultipleChoiceOption({required this.value, required this.image, required this.title, required this.description});
}

class MultipleChoiceController<MultipleChoiceType> extends StatefulWidget {
  final MultipleChoiceType currentSelected;
  final List<MultipleChoiceOption<MultipleChoiceType>> children;
  final Function(MultipleChoiceOption<MultipleChoiceType>) onSelectionChange;
  const MultipleChoiceController({
    super.key,
    required this.currentSelected,
    required this.children,
    required this.onSelectionChange,
  });

  @override
  State<MultipleChoiceController<MultipleChoiceType>> createState() =>
      _MultipleChoiceControllerState<MultipleChoiceType>();
}

class _MultipleChoiceControllerState<MultipleChoiceType> extends State<MultipleChoiceController<MultipleChoiceType>> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.children.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = widget.children[index];
        return OnTapScaleInteractionComponent(
          config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
          child: GestureDetector(
            onTap: () {
              widget.onSelectionChange(item);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: BoxBorder.all(
                  color: widget.currentSelected == item.value ? ColorFactory.accentColor : Colors.black.withAlpha(90),
                  width: widget.currentSelected == item.value ? 1 : 0.3,
                ),
                color: widget.currentSelected == item.value ? ColorFactory.accentColor.withAlpha(20) : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(item.image, width: 100, height: 100),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              item.title,
                              textAlign: TextAlign.left,
                              style: UIHelper.current.funnelTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              item.description,
                              textAlign: TextAlign.left,
                              style: UIHelper.current.funnelTextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
