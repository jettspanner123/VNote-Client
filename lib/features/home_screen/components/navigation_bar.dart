import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/home.controller.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.bloc.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.event.dart';
import 'package:vnote_client/utils/ui_helper.dart';

final List<(String, IconData, HomeScreenPageOptions, HomeScreenControllerEvent)> NavigationBarOptions = [
  ("Home", Icons.home, HomeScreenPageOptions.dashboard, HomeScreenDashboardPressed()),
  ("Stats", Icons.auto_graph, HomeScreenPageOptions.statistics, HomeScreenStatisticsPressed()),
  ("Scan", Icons.scanner, HomeScreenPageOptions.scan, HomeScreenScanPressed()),
  ("Card", Icons.credit_card, HomeScreenPageOptions.card, HomeScreenCardPressed()),
  ("Profile", Icons.person, HomeScreenPageOptions.profile, HomeScreenProfilePressed()),
];

class NavigationBarComponent extends StatefulWidget {
  const NavigationBarComponent({super.key});

  @override
  State<NavigationBarComponent> createState() => NavigationBarComponentState();
}

class NavigationBarComponentState extends State<NavigationBarComponent> {
  @override
  Widget build(BuildContext context) {
    final homeScreenBloc = context.read<HomeScreenControllerBloc>();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: BoxBorder.all(color: Colors.black.withAlpha(20), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            spacing: 5,
            children: NavigationBarOptions.map(
              (item) => NavigationBarItemComponent(
                name: item.$1,
                icon: item.$2,
                value: item.$3,
                globalValue: homeScreenBloc.state.currentPage,
                event: item.$4,
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class NavigationBarItemComponent extends StatefulWidget {
  final String name;
  final IconData icon;
  final HomeScreenPageOptions value;
  final HomeScreenPageOptions globalValue;
  final HomeScreenControllerEvent event;
  const NavigationBarItemComponent({
    super.key,
    required this.name,
    required this.icon,
    required this.value,
    required this.globalValue,
    required this.event,
  });

  @override
  State<NavigationBarItemComponent> createState() => _NavigationBarItemComponentState();
}

class _NavigationBarItemComponentState extends State<NavigationBarItemComponent> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    final homeScreenControllerBloc = context.read<HomeScreenControllerBloc>();
    return Expanded(
      child: Listener(
        onPointerDown: (_) {
          setState(() {
            isTapped = true;
          });
        },
        onPointerCancel: (_) {
          setState(() {
            isTapped = false;
          });
        },
        onPointerUp: (_) async {
          setState(() {
            isTapped = false;
          });
          await HapticFeedback.lightImpact();
          homeScreenControllerBloc.add(widget.event);
        },
        child: widget.value == HomeScreenPageOptions.scan
            ? Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorFactory.accentColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.icon, color: Colors.white),
                    Text(widget.name, style: UIHelper.current.funnelTextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
              )
            : AnimatedScale(
                scale: isTapped ? 0.9 : 1.0,
                duration: 150.milliseconds,
                child: Opacity(
                  opacity: widget.globalValue == widget.value ? 1.0 : 0.6,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: widget.globalValue == widget.value
                          ? ColorFactory.accentColor.withAlpha(40)
                          : isTapped
                          ? Colors.grey.withAlpha(40)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: BoxBorder.all(
                        color: widget.globalValue == widget.value ? Colors.black.withAlpha(20) : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(widget.icon),
                        Transform.translate(
                          offset: const Offset(0, -3),
                          child: Text(
                            widget.name,
                            style: UIHelper.current.funnelTextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
