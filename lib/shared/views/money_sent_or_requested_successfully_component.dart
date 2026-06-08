import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/services/audio_service.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/others/animated_success_badge.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/utils/ui_helper.dart';

enum MoneySentOrRequestedSuccessfullyFlowDirection { SENT, REQUESTED }

class MoneySentOrRequestedSuccessfullyComponent extends StatefulWidget {
  final MoneySentOrRequestedSuccessfullyFlowDirection moneyFlowDirection;
  const MoneySentOrRequestedSuccessfullyComponent({super.key, required this.moneyFlowDirection});

  @override
  State<MoneySentOrRequestedSuccessfullyComponent> createState() => MoneySentOrRequestedSuccessfullyComponentState();
}

class MoneySentOrRequestedSuccessfullyComponentState extends State<MoneySentOrRequestedSuccessfullyComponent>
    with TickerProviderStateMixin {
  late final AnimationController _badgeController;
  late final AnimationController _titleController;
  late final AnimationController _subtitleController;

  late final Animation<Offset> _badgeSlide;
  late final Animation<double> _badgeFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _subtitleFade;

  static const _duration = Duration(milliseconds: 600);
  static const _curve = Cubic(0.22, 1, 0.36, 1); // ease-out-quint

  Animation<Offset> _buildSlide(AnimationController c) =>
      Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero).animate(CurvedAnimation(parent: c, curve: _curve));

  Animation<double> _buildFade(AnimationController c) =>
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: c, curve: _curve));

  AnimationController _makeController() => AnimationController(vsync: this, duration: _duration);

  @override
  void initState() {
    super.initState();

    _badgeController = _makeController();
    _titleController = _makeController();
    _subtitleController = _makeController();

    _badgeSlide = _buildSlide(_badgeController);
    _badgeFade = _buildFade(_badgeController);
    _titleSlide = _buildSlide(_titleController);
    _titleFade = _buildFade(_titleController);
    _subtitleSlide = _buildSlide(_subtitleController);
    _subtitleFade = _buildFade(_subtitleController);

    // Staggered starts — each kicks off 150ms after the previous,
    // but they all run concurrently (600ms duration each).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) _badgeController.forward();
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) _titleController.forward();
      });
      Future.delayed(const Duration(milliseconds: 550), () {
        if (mounted) _subtitleController.forward();
      });
      Future.delayed(350.ms, _playSoundAfterDelay);
    });
  }

  @override
  void dispose() {
    _badgeController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _playSoundAfterDelay() async {
    AudioService.current.play(AppSounds.MONEY_TRANSFERED_SUCCESSFUL);
  }

  Future<void> _handleFloatingActionButtonTap() async {
    final navigator = Navigator.of(context);

    navigator.pop();

    await Future.delayed(const Duration(milliseconds: 200));

    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: ColorFactory.accentColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              FadeTransition(
                opacity: _badgeFade,
                child: SlideTransition(position: _badgeSlide, child: AnimatedSuccessBadgeComponent(size: 325)),
              ),
              FadeTransition(
                opacity: _titleFade,
                child: SlideTransition(
                  position: _titleSlide,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Money Request Successfully!",
                      textAlign: TextAlign.center,
                      style: UIHelper.current.funnelTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _subtitleFade,
                child: SlideTransition(
                  position: _subtitleSlide,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "A money thig has beeing happened with some shit kind of person bitch!",
                      textAlign: TextAlign.center,
                      style: UIHelper.current.funnelTextStyle(color: Colors.white.withAlpha(200)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: StandardButtonComponent(
          onTap: _handleFloatingActionButtonTap,
          child: StandardButtonText(text: "Continue"),
        ),
      ),
    );
  }
}
