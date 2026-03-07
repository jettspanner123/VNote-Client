import 'package:flutter/material.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class AppbarHeadingComponent extends StatelessWidget {
  final String title;

  const AppbarHeadingComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: UIHelper.current.funnelTextStyle());
  }
}
