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
                  AppbarActionButton(),
                  AppbarActionButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
