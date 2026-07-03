import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/application_bar_dismiss_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;
    final isDark = colorMode == AppColorMode.DARK;

    final sheetBgColor = isDark ? const Color(0xFF1C1C1E) : Colors.grey.shade50;
    final innerCardBgColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final textMutedColor = textColor.withAlpha(120);
    final borderColor = isDark ? Colors.white.withAlpha(15) : Colors.black.withAlpha(15);

    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = screenHeight * 0.90;

    final mockNotifications = [
      _NotificationItem(
        icon: Icons.call_received_rounded,
        iconColor: const Color(0xFF10B981),
        title: "Money Received",
        message: "You received \$25.00 from +1 555-0199.",
        time: "2 hours ago",
      ),
      _NotificationItem(
        icon: Icons.call_made_rounded,
        iconColor: const Color(0xFFEF4444),
        title: "Payment Sent",
        message: "Sent \$10.00 to +1 555-0142 successfully.",
        time: "5 hours ago",
      ),
      _NotificationItem(
        icon: Icons.security_rounded,
        iconColor: const Color(0xFFF59E0B),
        title: "Security Alert",
        message: "Your VNote account was logged in from a new device in San Francisco, CA.",
        time: "Yesterday",
      ),
      _NotificationItem(
        icon: Icons.monetization_on_rounded,
        iconColor: const Color(0xFF3B82F6),
        title: "Request Received",
        message: "John Doe requested \$15.00 from your account.",
        time: "2 days ago",
      ),
      _NotificationItem(
        icon: Icons.check_circle_rounded,
        iconColor: const Color(0xFF10B981),
        title: "KYC Verified",
        message: "Your profile verification checks completed successfully.",
        time: "3 days ago",
      ),
    ];

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: sheetBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Stack(
          children: [
            // 1. Scrollable contents
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 130, bottom: 40),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: innerCardBgColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: borderColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(isDark ? 10 : 4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mockNotifications.length,
                        separatorBuilder: (context, index) => Divider(color: borderColor, height: 24),
                        itemBuilder: (context, index) {
                          final item = mockNotifications[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: item.iconColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(item.icon, color: item.iconColor, size: 18),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.title,
                                          style: UIHelper.current.funnelTextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w700,
                                            color: textColor,
                                          ),
                                        ),
                                        Text(
                                          item.time,
                                          style: UIHelper.current.funnelTextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: textMutedColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item.message,
                                      style: UIHelper.current.funnelTextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500,
                                        color: textColor.withAlpha(200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Floating App Bar Header
            AppbarComponent(
              positioned: true,
              top: 20.0,
              children: [
                const ApplicationBarDismissButtonComponent(),
                Text(
                  "Notifications",
                  style: UIHelper.current.funnelTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 50), // Balance dismiss button to center text
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;

  _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
  });
}
