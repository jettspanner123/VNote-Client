import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/dashboard.action_button.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';
import 'package:vnote_client/shared/components/page/navbar_safe_page_padding.dart';
import 'package:vnote_client/utils/ui_helper.dart';
import '../constants/dashboard.action_buttons.dart';

class DashboardMainContentController extends StatefulWidget {
  const DashboardMainContentController({super.key});

  @override
  State<DashboardMainContentController> createState() => _DashboardMainContentControllerState();
}

class _DashboardMainContentControllerState extends State<DashboardMainContentController> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: NavbarSafePagePadding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorFactory.backgroundColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),

                // MARK: Screen Header with Appbar and action buttons
                child: Column(
                  children: [
                    AppbarComponent(
                      positioned: false,
                      children: [
                        AppbarActionButton(child: Icon(Icons.menu)),
                        Text(
                          "Dashboard",
                          style: UIHelper.current.funnelTextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        AppbarActionButton(child: Icon(Icons.notifications)),
                      ],
                    ),

                    // MARK: Dashboard "Your Balance".
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        spacing: 0,
                        children: [
                          Text(
                            "Your Balance",
                            style: UIHelper.current.funnelTextStyle(color: Colors.black.withAlpha(100)),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -5),
                            child: Text(
                              "₹90,000.12",
                              style: UIHelper.current.funnelTextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // MAKR: Dashboard Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        spacing: 10,
                        children: DASHBOARD_ACTION_BUTTONS
                            .map((action) => DashboardActionButtonComponent(action: action))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
