import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

import '../../../../constants/color_factory.dart';
import '../../../../utils/ui_helper.dart';

class DashboardTransferMoneyController extends StatelessWidget {
    const DashboardTransferMoneyController({super.key});

    @override
    Widget build(BuildContext context) {

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
        return Scaffold(
            backgroundColor: ColorFactory.accentColor,
            body: SafeArea(
                child: Column(
                    children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Transfer Money",
                                    style: UIHelper.current.funnelTextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Spacer(),
                                  AppbarActionButton(
                                    child: Icon(Icons.close_rounded, color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, darkValue: Colors.white, lightValue: Colors.black),),
                                    onTap: () => Navigator.of(context).pop(),
                                  ),
                                ],
                            ),
                        ),
                        // ── Add your transfer content here ──
                        const Expanded(
                            child: Center(
                                child: Text("Transfer content goes here", style: TextStyle(color: Colors.white70, fontSize: 16)),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
