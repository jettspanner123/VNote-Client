import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/components/navigation_bar.dart';
import 'package:vnote_client/features/home_screen/pages/card/card.contorller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/dashboard.controller.dart';
import 'package:vnote_client/features/home_screen/pages/profile/profile.controller.dart';
import 'package:vnote_client/features/home_screen/pages/statistics/statistics.controller.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.bloc.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.value.dart';

enum HomeScreenPageOptions { dashboard, statistics, add, card, profile }

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => _HomeScreenControllerState();
}

class _HomeScreenControllerState extends State<HomeScreenController> {
  Widget _buildCurrentPage(HomeScreenControllerState state) {
    switch (state.currentPage) {
      case HomeScreenPageOptions.dashboard:
        return const DashboardController();
      case HomeScreenPageOptions.statistics:
        return const StatisticsController();
      case HomeScreenPageOptions.card:
        return const CardController();
      case HomeScreenPageOptions.profile:
        return const ProfileContorller();
      case HomeScreenPageOptions.add:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenControllerBloc, HomeScreenControllerState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: KeyedSubtree(key: ValueKey(state.currentPage), child: _buildCurrentPage(state)),
                ),
              ),
              Positioned(bottom: 25, right: 15, left: 15, child: NavigationBarComponent()),
            ],
          ),
        );
      },
    );
  }
}
