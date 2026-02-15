import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/components/navigation_bar.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/dashboard.controller.dart';
import 'package:vnote_client/features/home_screen/pages/statistics/statistics.controller.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.bloc.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.value.dart';

enum HomeScreenPageOptions { dashboard, statistics, scan, card, profile }

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => _HomeScreenControllerState();
}

class _HomeScreenControllerState extends State<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenControllerBloc, HomeScreenControllerState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (state.currentPage == HomeScreenPageOptions.dashboard) const DashboardController(),
              if (state.currentPage == HomeScreenPageOptions.statistics) const StatisticsController(),
              Positioned(bottom: 25, right: 15, left: 15, child: NavigationBarComponent()),
            ],
          ),
        );
      },
    );
  }
}
