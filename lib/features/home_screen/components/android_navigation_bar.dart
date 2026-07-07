import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/components/navigation_bar.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.bloc.dart';

class AndroidNavigationBarComponent extends StatefulWidget {
    const AndroidNavigationBarComponent({super.key});

    @override
    State<AndroidNavigationBarComponent> createState() => _AndroidNavigationBarComponentState();
}

class _AndroidNavigationBarComponentState extends State<AndroidNavigationBarComponent> {

    @override
    Widget build(BuildContext context) {
        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
        final homeScreenBloc = context.watch<HomeScreenControllerBloc>();

        Color getForegroundColorForColorMode(AppColorMode colorMode) {
            if (colorMode == AppColorMode.DARK) return ColorFactory.darkForegroundColor;
            return Colors.white;
        }

        final safeAreaBottom = MediaQuery.of(context).padding.bottom;

        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: getForegroundColorForColorMode(globalColorModeBloc.state.colorMode),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                ),
                border: Border(
                    top: BorderSide(
                        color: globalColorModeBloc.state.colorMode == AppColorMode.LIGHT 
                            ? Colors.black.withAlpha(50) 
                            : Colors.white.withAlpha(50), 
                        width: 1,
                    ),
                ),
                boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(10), 
                        blurRadius: 10, 
                        offset: const Offset(0, -5),
                    )
                ],
            ),
            child: Padding(
                padding: EdgeInsets.only(
                    left: 16, 
                    right: 16, 
                    top: 8, 
                    bottom: safeAreaBottom > 0 ? safeAreaBottom - 8.0 : 3.0,
                ),
                child: SizedBox(
                    width: double.infinity,
                    child: Row(
                        spacing: 5,
                        children: NavigationBarOptions.map(
                            (item) => NavigationBarItemComponent(
                                name: item.$1,
                                activeIcon: item.$2,
                                inactiveIcon: item.$3,
                                value: item.$4,
                                globalValue: homeScreenBloc.state.currentPage,
                                event: item.$5,
                                showLabels: true,
                            ),
                        ).toList(),
                    ),
                ),
            ),
        );
    }
}
