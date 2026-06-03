import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class WelcomeScreenController extends StatefulWidget {
  const WelcomeScreenController({super.key});

  @override
  State<WelcomeScreenController> createState() => _WelcomeScreenControllerState();
}

class _WelcomeScreenControllerState extends State<WelcomeScreenController> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _uddeshyaCardSlideTransition;
  late Animation<Offset> _vanshikaCardSlideTransition;
  late Animation<Offset> _bottomContentSlideTransition;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: 1.seconds);
    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _uddeshyaCardSlideTransition = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);
    _vanshikaCardSlideTransition = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);
    _bottomContentSlideTransition = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _changeScreen() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Scaffold(
      backgroundColor: UIHelper.current.getValueAccordingToColorMode(
        colorMode: globalColorModeBloc.state.colorMode,
        darkValue: Colors.black,
        lightValue: Colors.white,
      ),
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
                  child: SlideTransition(
                    position: _uddeshyaCardSlideTransition,
                    child: Transform.rotate(
                      angle: -50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Colors.white.withAlpha(50), width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset("assets/images/others/uddeshya_card.png", height: 250),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: -150,
                  child: SlideTransition(
                    position: _vanshikaCardSlideTransition,
                    child: Transform.rotate(
                      angle: -50,
                      child: Image.asset("assets/images/others/vanshika_card.png", height: 250),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SlideTransition(
                    position: _bottomContentSlideTransition,
                    child: Container(
                      // decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          ColorModeAwareTextComponent(
                            text: "Take control of you finances on just your phone.",
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
                              color: UIHelper.current.getValueAccordingToColorMode(
                                colorMode: globalColorModeBloc.state.colorMode,
                                darkValue: Colors.white.withAlpha(110),
                                lightValue: Colors.black.withAlpha(110),
                              ),
                            ),
                          ),

                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: StandardButtonComponent(
                              backgroundColor: UIHelper.current.getValueAccordingToColorMode(
                                colorMode: globalColorModeBloc.state.colorMode,
                                darkValue: ColorFactory.accentColor,
                                lightValue: Colors.black,
                              ),
                              onTap: _changeScreen,
                              child: StandardButtonText(text: "Let Us Get Started"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
