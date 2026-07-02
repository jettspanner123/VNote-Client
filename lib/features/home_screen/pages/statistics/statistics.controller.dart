import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/pages/statistics/components/statistics.main_content.controller.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class StatisticsController extends StatefulWidget {
  const StatisticsController({super.key});

  @override
  State<StatisticsController> createState() => _StatisticsControllerState();
}

class _StatisticsControllerState extends State<StatisticsController> {
  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Scaffold(
      backgroundColor: UIHelper.current.getBackgroundColorForColorMode(globalColorModeBloc.state.colorMode),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(children: [StatisticsMainContentController()]),
    );
  }
}
