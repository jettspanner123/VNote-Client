import 'package:flutter/material.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/dashboard.main_content.controller.dart';
import 'package:flutter/services.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

import '../../../../constants/color_factory.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({super.key});

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();

    UIHelper.current.setStatusBarColors(globalColorModeBloc.state.colorMode);

    Color getBackgroundColorForColorMode(AppColorMode colorMode) {
      if (colorMode == AppColorMode.DARK) return ColorFactory.darkBackgroundColor;
      return ColorFactory.backgroundColor;
    }

    return Scaffold(
      backgroundColor: getBackgroundColorForColorMode(globalColorModeBloc.state.colorMode),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(children: [DashboardMainContentController()]),
    );
  }
}

class AppBarActionButtonOption extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isEdge;

  const AppBarActionButtonOption({super.key, required this.title, required this.icon, required this.isEdge});

  @override
  State<AppBarActionButtonOption> createState() => _AppBarActionButtonOptionState();
}

class _AppBarActionButtonOptionState extends State<AppBarActionButtonOption> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        if (!_isTapped) return;
        setState(() {
          _isTapped = false;
        });
      },
      onPointerDown: (_) {
        if (_isTapped) return;
        setState(() {
          _isTapped = true;
        });
      },
      child: Container(
        color: _isTapped ? Colors.black.withAlpha(10) : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.isEdge ? 10 : 0, horizontal: 10),
          child: Row(spacing: 10, children: [Icon(widget.icon), Text("Hello, world")]),
        ),
      ),
    );
  }
}
