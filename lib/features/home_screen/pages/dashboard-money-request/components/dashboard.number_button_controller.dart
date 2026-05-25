import 'package:flutter/material.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_button_component.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/constants/dashboard.money_request_constants.dart';

class DashboardNumberButtonController extends StatelessWidget {
  final void Function(String value) onButtonTap;

  const DashboardNumberButtonController({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.75,
      children: DashboardMoneyRequestConstants.current.NUMBER_BUTTONS.map((value) {
        return DashboardNumberButtonComponent(value: value, onTap: () => onButtonTap(value));
      }).toList(),
    );
  }
}
