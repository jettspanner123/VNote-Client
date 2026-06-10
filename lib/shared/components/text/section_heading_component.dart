import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SectionheadingComponent extends StatefulWidget {
  final String text;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  const SectionheadingComponent({super.key, required this.text, this.secondaryButtonText, this.onSecondaryButtonTap});

  @override
  State<SectionheadingComponent> createState() => _SectionheadingComponentState();
}

class _SectionheadingComponentState extends State<SectionheadingComponent> {
  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ColorModeAwareTextComponent(text: widget.text, style: UIHelper.current.funnelTextStyle(fontSize: 24)),

        if (widget.secondaryButtonText != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.secondaryButtonText!,
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 15,
                  color: UIHelper.current.getValueAccordingToColorMode(
                    colorMode: globalColorModeBloc.state.colorMode,
                    darkValue: Colors.white.withAlpha(70),
                    lightValue: Colors.black.withAlpha(85),
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right,
                size: 25,
                color: UIHelper.current.getValueAccordingToColorMode(
                  colorMode: globalColorModeBloc.state.colorMode,
                  darkValue: Colors.white.withAlpha(70),
                  lightValue: Colors.black.withAlpha(85),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
