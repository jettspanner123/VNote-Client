import 'package:flutter/material.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/dashboard.main_content.controller.dart';
import 'package:flutter/services.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({super.key});

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
