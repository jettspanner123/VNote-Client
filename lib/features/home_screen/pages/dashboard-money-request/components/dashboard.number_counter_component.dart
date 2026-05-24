import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardNumberCounterComponent extends StatelessWidget {
  final String enteredRequestMoneyValue;

  const DashboardNumberCounterComponent({super.key, required this.enteredRequestMoneyValue});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final color = UIHelper.current.getValueAccordingToColorMode(
      colorMode: globalColorModeBloc.state.colorMode,
      darkValue: Colors.white,
      lightValue: const Color(0xFF06140D),
    );

    return Text(
      "₹$enteredRequestMoneyValue",
      style: UIHelper.current.funnelTextStyle(fontSize: 58, fontWeight: FontWeight.bold, color: color),
    );
  }
}
