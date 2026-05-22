import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

import '../../../../../../constants/color_factory.dart';
import '../../../../../../shared/interaction/tap_scale_interaction.dart';
import '../../../../../../utils/ui_helper.dart';

class DashboardMainContentActionButtonsController extends StatefulWidget {
    const DashboardMainContentActionButtonsController({super.key});

    @override
    State<DashboardMainContentActionButtonsController> createState() => _DashboardMainContentActionButtonsControllerState();
}

class _DashboardMainContentActionButtonsControllerState extends State<DashboardMainContentActionButtonsController> {
    @override
    Widget build(BuildContext context) {

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
        return Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Row(
                spacing: 5,
                children: [
                    Expanded(
                        child: OnTapScaleInteractionComponent(
                            config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
                            child: Container(
                                height: 65,
                                decoration: BoxDecoration(
                                    color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, darkValue: ColorFactory.darkForegroundColor, lightValue: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                    border: UIHelper.current.getDefaultBorder(colorMode: globalColorModeBloc.state.colorMode),
                                    boxShadow: [
                                        UIHelper.current.getDefaultBoxShadow()
                                    ],
                                ),
                                child: Padding(
                                    padding: const EdgeInsetsGeometry.all(5),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                            AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorFactory.accentColor,
                                                        borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: Icon(Icons.call_received_rounded, color: Colors.white),
                                                )
                                            ),
                                            Expanded(
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        ColorModeAwareTextComponent(text: "Request", style: UIHelper.current.funnelTextStyle(
                                                            fontSize: 16,
                                                        ))
                                                    ],
                                                ) 
                                            )
                                        ],
                                    ),
                                ),
                            ))),
                    Expanded(
                        child: OnTapScaleInteractionComponent(
                            config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
                            child: Container(
                                height: 65,
                                decoration: BoxDecoration(
                                    color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, darkValue: ColorFactory.darkForegroundColor, lightValue: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                    border: UIHelper.current.getDefaultBorder(colorMode: globalColorModeBloc.state.colorMode),
                                    boxShadow: [
                                        UIHelper.current.getDefaultBoxShadow()
                                    ],
                                ),
                                child: Padding(
                                    padding: const EdgeInsetsGeometry.all(5),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                            AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorFactory.accentColor,
                                                        borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: Icon(Icons.arrow_outward_rounded, color: Colors.white),
                                                )
                                            ),
                                            Expanded(
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        ColorModeAwareTextComponent(text: "Transfer", style: UIHelper.current.funnelTextStyle(
                                                            fontSize: 16,
                                                        ))
                                                    ],
                                                )
                                            )
                                        ],
                                    ),
                                ),
                            )))
                ],
            ),
        );
    }
}
