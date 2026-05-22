import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashboard.main_contetn_header.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashbord.main_content_action_buttons.dart';
import 'package:vnote_client/shared/components/page/navbar_safe_page_padding.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardMainContentController extends StatefulWidget {
    const DashboardMainContentController({super.key});

    @override
    State<DashboardMainContentController> createState() => _DashboardMainContentControllerState();
}

class _DashboardMainContentControllerState extends State<DashboardMainContentController> {
    @override
    Widget build(BuildContext context) {

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();

        String getTemplateCardImageForColorMode(AppColorMode colorMode) {
            if (colorMode == AppColorMode.DARK) return "assets/images/template/card_dark_mode.png";
            return "assets/images/template/card_light_mode.png";
        }

        return Positioned.fill(
            child: NavbarSafePagePadding(
                padding: const EdgeInsets.all(0),
                child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 10,),
                    child: ListView(
                        children: [
                            DashboardMainContentHeaderController(),
                            SizedBox(height: 10),
                            Padding(
                                padding: const EdgeInsetsGeometry.symmetric(horizontal: 10), 
                                child: Image.asset(getTemplateCardImageForColorMode(globalColorModeBloc.state.colorMode)),
                            ),
                            SizedBox(height: 10),
                            DashboardMainContentActionButtonsController(),

                            Padding(
                                padding: const EdgeInsetsGeometry.only(left: 15, right: 15, bottom: 10, top: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        ColorModeAwareTextComponent(text: "Transactions", style: UIHelper.current.funnelTextStyle(
                                            fontSize: 24,
                                        )),

                                        Spacer(),

                                        Container(
                                            child: Padding(
                                                padding: const EdgeInsetsGeometry.all(15),
                                                child: Row(
                                                    children: [
                                                        Text("See More", style: UIHelper.current.funnelTextStyle(
                                                                fontSize: 15,
                                                                color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, darkValue: Colors.white.withAlpha(70), lightValue: Colors.black.withAlpha(85))
                                                            ),
                                                        )
                                                    ],
                                                ),
                                            ),
                                        ) 
                                    ],
                                ),
                            ),
                        ]
                    ),
                ),
            ),
        );
    }
}
