import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vnote_client/shared/components/page/navbar_safe_page_padding.dart';

class DashboardMainContentController extends StatefulWidget {
  const DashboardMainContentController({super.key});

  @override
  State<DashboardMainContentController> createState() => _DashboardMainContentControllerState();
}

class _DashboardMainContentControllerState extends State<DashboardMainContentController> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: NavbarSafePagePadding(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          padding: const EdgeInsets.only(bottom: 150),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: [Colors.red, Colors.blue, Colors.orange][Random().nextInt(3)],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(child: Text(index.toString())),
            );
          },
        ),
      ),
    );
  }
}
