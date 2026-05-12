import "package:flutter/material.dart";
import "package:vnote_client/shared/components/buttons/button_text.dart";
import "package:vnote_client/shared/components/buttons/regular_button.dart";
import "package:vnote_client/shared/components/page/page_button_holder.dart";

class SubscriptionController extends StatefulWidget {
  const SubscriptionController({super.key});

  @override
  State<SubscriptionController> createState() => _SubscriptionControllerState();
}

class _SubscriptionControllerState extends State<SubscriptionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: StandardButtonComponent(child: StandardButtonText(text: "Buy Shit!")),
      ),
    );
  }
}
