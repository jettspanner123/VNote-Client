import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class LanguageSelectorController extends StatefulWidget {
  const LanguageSelectorController({super.key});

  @override
  State<LanguageSelectorController> createState() => LanguageSelectorControllerState();
}

class LanguageSelectorControllerState extends State<LanguageSelectorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: ComponentConstants.screenHorizontalPadding,
          children: [
            SizedBox(height: 30),
            Text(
              "Select Your Prefered Language",
              style: UIHelper.current.funnelTextStyle(fontSize: 35, fontWeight: FontWeight.bold, height: 1.05),
            ),
            SizedBox(height: 20),
            Text(
              "Select your preferred language to continue. You can change it later from settings.",
              style: UIHelper.current.funnelTextStyle(fontSize: 18, color: Colors.black.withAlpha(110)),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: SizedBox(
          width: double.infinity,
          child: StandardButtonComponent(child: StandardButtonText(text: "Continue")),
        ),
      ),
    );
  }
}
