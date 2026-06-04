import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/services/audio_service.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/page_button_holder.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

enum MoneySentOrRequestedSuccessfullyFlowDirection { SENT, REQUESTED }

class MoneySentOrRequestedSuccessfullyComponent extends StatefulWidget {
  final MoneySentOrRequestedSuccessfullyFlowDirection moneyFlowDirection;
  const MoneySentOrRequestedSuccessfullyComponent({super.key, required this.moneyFlowDirection});

  @override
  State<MoneySentOrRequestedSuccessfullyComponent> createState() => MoneySentOrRequestedSuccessfullyComponentState();
}

class MoneySentOrRequestedSuccessfullyComponentState extends State<MoneySentOrRequestedSuccessfullyComponent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(350.ms, () {
        _playSoundAfterDelay();
      });
    });
  }

  Future<void> _playSoundAfterDelay() async {
    AudioService.current.play(AppSounds.MONEY_TRANSFERED_SUCCESSFUL);
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: ColorFactory.accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StandardButtonComponent(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: StandardButtonText(text: "Go Back Bitch"),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonHolderComponent(
        child: StandardButtonComponent(child: StandardButtonText(text: "Continue")),
      ),
    );
  }
}
