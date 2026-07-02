import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashboard.main_contetn_header.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashboard.transaction_tile.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashbord.main_content_action_buttons.dart';
import 'package:vnote_client/models/mock/transaction_mock_model.dart';
import 'package:vnote_client/services/mock_data_service.dart';
import 'package:vnote_client/shared/components/page/main_page_holder_component.dart';
import 'package:vnote_client/shared/components/text/section_heading_component.dart';
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

    UIHelper.current.setStatusBarColors(globalColorModeBloc.state.colorMode);

    String getTemplateCardImageForColorMode(AppColorMode colorMode) {
      if (colorMode == AppColorMode.DARK) return "assets/images/template/card_dark_mode.png";
      return "assets/images/template/card_light_mode.png";
    }

    final recentTransactions = (List<TransactionMockModel>.from(
      MockDataService.current.RECENT_TRANSACTIONS,
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt))).take(5).toList();

    return MainPageHolderComponent(
      children: [
        DashboardMainContentHeaderController(),
        SizedBox(height: 20),
        Image.asset(getTemplateCardImageForColorMode(globalColorModeBloc.state.colorMode)),
        SizedBox(height: 10),
        DashboardMainContentActionButtonsController(),

        // Padding(
        //   padding: const EdgeInsetsGeometry.only(left: 10, right: 0, bottom: 10, top: 20),
        //   child: SectionHeadingComponent(text: "Recent Activity", secondaryButtonText: "See More"),
        // ),
        SectionHeadingComponent(
          text: "Recent Activity", 
          secondaryButtonText: "See More",
          onSecondaryButtonTap: () {
            Navigator.pushNamed(context, NavigationFactory.transactionHistoryScreen);
          },
        ),

        ...recentTransactions.map((transaction) => DashboardTransactionCardComponent(transaction: transaction)),

        SizedBox(height: 120),
      ],
    );
  }
}
