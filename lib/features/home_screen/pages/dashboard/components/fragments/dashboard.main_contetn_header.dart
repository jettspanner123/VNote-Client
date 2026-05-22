import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../constants/color_factory.dart';
import '../../../../../../shared/components/page/appbar_action_button.dart';
import '../../../../../../shared/components/text/color_mode_aware_text.dart';
import '../../../../../../store/global_bloc/global_color_mode.bloc.dart';
import '../../../../../../store/global_bloc/global_color_mode.event.dart';
import '../../../../../../utils/ui_helper.dart';

class DashboardMainContentHeaderController extends StatefulWidget {
    const DashboardMainContentHeaderController({super.key});

    @override
    State<DashboardMainContentHeaderController> createState() => _DashboardMainContentHeaderState();
}

class _DashboardMainContentHeaderState extends State<DashboardMainContentHeaderController> {
    @override
    Widget build(BuildContext context) {

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
        return Padding(
            padding: const EdgeInsetsGeometry.all(10),
            child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorFactory.accentColor,
                    ),

                    Column(
                        spacing: 0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text("Welcome Back", style: UIHelper.current.funnelTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, darkValue: Colors.white.withAlpha(80), lightValue: Colors.black.withAlpha(50)),
                                height: 0.6
                            )),
                            ColorModeAwareTextComponent(text: "Uddeshya", style: UIHelper.current.funnelTextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                            ),),
                        ],
                    ),
                    Spacer(),
                    AppbarActionButton(child: Icon(globalColorModeBloc.state.colorMode == AppColorMode.LIGHT ? Icons.dark_mode : Icons.light_mode, color: UIHelper.current.getTextColorForColorMode(globalColorModeBloc.state.colorMode),), onTap: () {
                        if (globalColorModeBloc.state.colorMode == AppColorMode.LIGHT) {
                            globalColorModeBloc.add(GlobalColorModeChangedToDark());
                        }
                        else {
                            globalColorModeBloc.add(GlobalColorModeChangedToLight());
                        }
                    },),
                    AppbarActionButton(child: Icon(Icons.notifications, color: UIHelper.current.getTextColorForColorMode(globalColorModeBloc.state.colorMode),))
                ],
            ),
        );
    }
}
