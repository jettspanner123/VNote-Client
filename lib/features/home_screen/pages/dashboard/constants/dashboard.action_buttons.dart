import 'package:flutter/material.dart';

import '../../../../../constants/color_factory.dart';
import '../helpers/dashboard.header_action.dart';

final List<DashboardHeaderAction> DASHBOARD_ACTION_BUTTONS = [
  DashboardHeaderAction(
    title: "Send",
    iconImage: "assets/icons/dashboard/send.png",
    accentColor: ColorFactory.accentColor,
    padding: EdgeInsets.all(15),
  ),
  DashboardHeaderAction(
    title: "Request",
    iconImage: "assets/icons/dashboard/recieve.png",
    accentColor: Colors.white,
    padding: EdgeInsets.all(15),
  ),
  DashboardHeaderAction(
    title: "Exchange",
    iconImage: "assets/icons/dashboard/exchange.png",
    accentColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
  ),
  DashboardHeaderAction(
    title: "More",
    iconImage: "assets/icons/dashboard/more.png",
    accentColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
  ),
];
