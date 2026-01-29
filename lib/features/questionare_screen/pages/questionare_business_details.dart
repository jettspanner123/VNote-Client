import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/questionare_screen/questionare.components.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';

enum QuestionareTypeOfBusiness { retailShop, foodRestraunt, services, professional, onlineIt, others, none }

class QuestionareBusinessDetailsView extends StatefulWidget {
  final TextEditingController businessNameController;
  final TextEditingController otherBusinessController;
  const QuestionareBusinessDetailsView({
    super.key,
    required this.businessNameController,
    required this.otherBusinessController,
  });

  @override
  State<QuestionareBusinessDetailsView> createState() => _QuestionareBusinessDetailsViewState();
}

class _QuestionareBusinessDetailsViewState extends State<QuestionareBusinessDetailsView> {
  QuestionareTypeOfBusiness _businessType = QuestionareTypeOfBusiness.none;
  final _scrollController = ScrollController();

  void _handleOnKeyboardOpen() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 100),
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
            QuestionareProgressIndicatorComponent(currentScreen: 2),
            QuestionareTopSpaceHeight,
            QuestionareHeadingComponent(text: "Tell us about your business."),
            QuestionareSpacerHeight,
            QuestionareDescriptionComponent(
              text: "Please help us understand more about your business for personalized experience.",
            ),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "Business's Name"),
            StandardInputField(icon: Icon(Icons.store), textController: widget.businessNameController),
            QuestionareSpacerHeight,
            StandardInputLabelComponent(text: "What's the type of your business?"),

            MultipleChoiceController<QuestionareTypeOfBusiness>(
              currentSelected: _businessType,
              children: [
                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.retailShop,
                  image: "assets/images/questionare_image/shop_retailer.png",
                  title: "Retail / Shop",
                  description: "Clothing, grocery, electronics, stationery, cosmetics, general store",
                ),

                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.foodRestraunt,
                  image: "assets/images/questionare_image/food_restraunt.png",
                  title: "Food & Restaurant",
                  description: "Restaurant, café, bakery, cloud kitchen, catering, food stall",
                ),

                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.services,
                  image: "assets/images/questionare_image/services.png",
                  title: "Services",
                  description: "Salon, repair, cleaning, electrician, plumber, home services",
                ),

                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.professional,
                  image: "assets/images/questionare_image/professional.png",
                  title: "Professional",
                  description: "Doctor, lawyer, accountant, consultant, agency, coaching/training",
                ),

                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.onlineIt,
                  image: "assets/images/questionare_image/it_digital.png",
                  title: "Online / IT / Digital",
                  description: "Freelancing, software services, online business, digital marketing, eCommerce",
                ),

                MultipleChoiceOption(
                  value: QuestionareTypeOfBusiness.others,
                  image: "assets/images/questionare_image/others.png",
                  title: "Other",
                  description: "Manufacturing, wholesale, transport, real estate, anything else",
                ),
              ],
              onSelectionChange: (data) {
                if (data.value == QuestionareTypeOfBusiness.others) {
                  _handleOnKeyboardOpen();
                }
                setState(() {
                  _businessType = data.value;
                });
              },
            ),

            QuestionareSpacerHeight,
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut),
                child: child,
              ),
              child: _businessType == QuestionareTypeOfBusiness.others
                  ? Column(
                      key: ValueKey("other_business_name_input"),
                      children: [
                        StandardInputLabelComponent(text: "Explain your business in 4 - 5 words"),
                        StandardInputField(
                          onFocus: _handleOnKeyboardOpen,
                          placeholder: "Custom Business Type",
                          icon: Icon(Icons.store),
                          textController: widget.otherBusinessController,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
