import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SecondarySectionHeaderComponent extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const SecondarySectionHeaderComponent({super.key, required this.text, this.padding = const EdgeInsets.only(top: 8)});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final mutedTextColor = textColor.withAlpha(140);

    return Padding(
      padding: padding,
      child: Text(
        text.toUpperCase(),
        style: UIHelper.current.funnelTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: mutedTextColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
