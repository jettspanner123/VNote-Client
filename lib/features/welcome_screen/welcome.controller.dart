import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class WelcomeScreenController extends StatefulWidget {
  const WelcomeScreenController({super.key});

  @override
  State<WelcomeScreenController> createState() => _WelcomeScreenControllerState();
}

class _WelcomeScreenControllerState extends State<WelcomeScreenController> {
  void _changeScreen() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: ComponentConstants.screenHorizontalPadding,
          child: SizedBox.expand(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 150,
                  left: -130,
                  child: Transform.rotate(
                    angle: -50,
                    child: Image.asset("assets/images/others/uddeshya_card.png", height: 250),
                  ),
                ).animate().slideX(begin: -1, end: 0, duration: 1.seconds, curve: Curves.fastEaseInToSlowEaseOut),
                Positioned(
                  top: 70,
                  right: -150,
                  child: Transform.rotate(
                    angle: -50,
                    child: Image.asset("assets/images/others/vanshika_card.png", height: 250),
                  ),
                ).animate().slideX(begin: 1, end: 0, duration: 1.25.seconds, curve: Curves.fastEaseInToSlowEaseOut),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Text(
                          "Take control of you finances on just your phone.",
                          style: UIHelper.current.funnelTextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Convenience to control and manage your finances in one place to save your time.",
                          style: UIHelper.current.funnelTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            height: 1.05,
                            color: Colors.black.withAlpha(110),
                          ),
                        ),

                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: StandardButtonComponent(
                            onTap: _changeScreen,
                            child: StandardButtonText(text: "Let Us Get Started"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().slideY(
                  begin: 1.5,
                  end: 0,
                  duration: 1.seconds,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  delay: 500.ms,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
