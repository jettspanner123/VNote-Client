import 'package:flutter/material.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/dashboard.main_content.controller.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({super.key});

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DashboardeMainContentController(),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarActionButton(
                    expandInto: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: SizedBox.expand(
                        child: Column(
                          spacing: 0,
                          children: [
                            AppBarActionButtonOption(title: "Contacts", icon: Icons.person, isEdge: true,),
                            Divider(indent: 1,),
                            AppBarActionButtonOption(title: "Contacts", icon: Icons.person, isEdge: true,),
                          ],
                        ),
                      ),
                    ),
                    expandHeight: 106,
                    child: Icon(Icons.add),
                  ),
                  AppbarActionButton(
                    child: Icon(Icons.person),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
        if(!_isTapped) return;
        setState(() {
          _isTapped = false;
        });
      },
      onPointerDown: (_) {
        if(_isTapped) return;
        setState(() {
          _isTapped = true;
        });
      },
      child: Container(
        color: _isTapped ? Colors.black.withAlpha(10) : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.isEdge ? 10 : 0, horizontal: 10),
          child: Row(
            spacing: 10,
            children: [
              Icon(widget.icon),
              Text("Hello, world")
            ],
          ),
        ),
      ),
    );
  }
}
