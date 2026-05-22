import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

class ColorModeAwareTextComponent extends StatefulWidget {
    final String text;
    final TextStyle? style;
    const ColorModeAwareTextComponent({super.key, required this.text, required this.style});

    @override
    State<ColorModeAwareTextComponent> createState() => _ColorModeAwareTextComponentState();
}

class _ColorModeAwareTextComponentState extends State<ColorModeAwareTextComponent> {
    @override
    Widget build(BuildContext context) {

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
        return Text(widget.text, style: widget.style?.copyWith(
            color: globalColorModeBloc.state.colorMode == AppColorMode.LIGHT ? Colors.black : Colors.white
        ));
    }
}
