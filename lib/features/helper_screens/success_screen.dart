import 'package:flutter/material.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/shared/animations/slide_animation_controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/others/animated_success_badge.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SuccessControllerScreen extends StatefulWidget {
  final double badgeIconSize;
  final String heading;
  final String description;
  final String navigationButtonText;
  final VoidCallback? onButtonTap;
  const SuccessControllerScreen({
    super.key,
    this.badgeIconSize = 250,
    required this.heading,
    required this.description,
    required this.navigationButtonText,
    this.onButtonTap,
  });

  @override
  State<SuccessControllerScreen> createState() => _SuccessControllerScreenState();
}

class _SuccessControllerScreenState extends State<SuccessControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: ComponentConstants.screenHorizontalPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideAnimationControllerComponent(
                  slideOffset: SlideAnimationValue(begin: const Offset(0, 2), end: const Offset(0, 0)),
                  child: AnimatedSuccessBadgeComponent(size: widget.badgeIconSize),
                ),

                SizedBox(height: 20),

                SlideAnimationControllerComponent(
                  slideOffset: SlideAnimationValue(begin: const Offset(0, 2), end: const Offset(0, 0)),
                  child: Text(
                    widget.heading,
                    style: UIHelper.current.newAmsterdamTextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 10),

                SlideAnimationControllerComponent(
                  slideOffset: SlideAnimationValue(begin: const Offset(0, 2), end: const Offset(0, 0)),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: UIHelper.current.funnelTextStyle(fontSize: 16),
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SlideAnimationControllerComponent(
        slideOffset: SlideAnimationValue(begin: const Offset(0, 1), end: const Offset(0, 0)),
        child: FloatingButtonHolderComponent(
          child: StandardButtonComponent(
            onTap: widget.onButtonTap,
            child: StandardButtonText(text: widget.navigationButtonText),
          ),
        ),
      ),
    );
  }
}
