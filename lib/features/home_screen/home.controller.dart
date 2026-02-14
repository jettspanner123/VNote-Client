import 'package:flutter/material.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/dashboard.controller.dart';

enum HomeScreenPageOptions { dashboard, statistics, scan, card, profile }

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => _HomeScreenControllerState();
}

class _HomeScreenControllerState extends State<HomeScreenController> {
  HomeScreenPageOptions currentPage = HomeScreenPageOptions.dashboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DashboardController());
  }
}
