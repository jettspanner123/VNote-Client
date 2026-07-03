import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/models/mock/transaction_mock_model.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/application_bar_dismiss_button.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class TransactionDetailSheet extends StatelessWidget {
  final TransactionMockModel transaction;

  const TransactionDetailSheet({super.key, required this.transaction});

  static void show(BuildContext context, TransactionMockModel transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailSheet(transaction: transaction),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year} at $hour:$minute $period';
  }

  Color _getStatusColor(TransactionMockStatus status) {
    switch (status) {
      case TransactionMockStatus.COMPLETED:
        return const Color(0xFF10B981);
      case TransactionMockStatus.PENDING:
        return const Color(0xFFF59E0B);
      case TransactionMockStatus.FAILED:
      case TransactionMockStatus.CANCELLED:
        return const Color(0xFFEF4444);
    }
  }

  Widget _buildDashedDivider(Color color) {
    return Row(
      children: List.generate(
        40,
        (index) => Expanded(child: Container(color: index % 2 == 0 ? Colors.transparent : color, height: 1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    final isCredit = transaction.transactionDirection == TransactionMockDirection.CREDIT;
    final amountColor = isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final sign = isCredit ? '+' : '-';

    // Sheet background: dark grey (instead of black) for dark mode
    final sheetBgColor = colorMode == AppColorMode.DARK ? const Color(0xFF1C1C1E) : Colors.grey.shade50;

    // Inner card background: slightly lighter than the sheet background
    final innerCardBgColor = colorMode == AppColorMode.DARK ? const Color(0xFF2C2C2E) : Colors.white;

    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final textMutedColor = textColor.withAlpha(120);
    final borderColor = colorMode == AppColorMode.LIGHT ? Colors.black.withAlpha(15) : Colors.white.withAlpha(15);

    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = screenHeight * 0.90; // 90% full-screen height

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: sheetBgColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: Stack(
          children: [
            // 1. Scrollable middle section (offsets by 120px to slide beneath the AppbarComponent blur)
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 110),
                child: Column(
                  children: [
                    // Large Amount Display
                    Text(
                      "$sign\$${transaction.amount.toStringAsFixed(2)}",
                      style: GoogleFonts.oswald(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: amountColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(transaction.transactionStatus).withAlpha(25),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: _getStatusColor(transaction.transactionStatus).withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _getStatusColor(transaction.transactionStatus),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            transaction.transactionStatus.name,
                            style: UIHelper.current.funnelTextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: _getStatusColor(transaction.transactionStatus),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Styled Divider imitating paper cuts/punches
                    _buildDashedDivider(borderColor),
                    const SizedBox(height: 25),

                    // Details List Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: innerCardBgColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: borderColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(colorMode == AppColorMode.LIGHT ? 4 : 10),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildDetailBlock(
                            context: context,
                            icon: Icons.phone_iphone_rounded,
                            iconColor: Colors.blue,
                            label: "Recipient / Sender Phone",
                            value: transaction.secondaryUserPhoneNumber,
                            textColor: textColor,
                            textMutedColor: textMutedColor,
                          ),
                          Divider(color: borderColor, height: 18),
                          _buildDetailBlock(
                            context: context,
                            icon: Icons.fingerprint_rounded,
                            iconColor: Colors.purple,
                            label: "Transaction ID",
                            value: transaction.transactionId,
                            textColor: textColor,
                            textMutedColor: textMutedColor,
                            useOswald: true,
                          ),
                          Divider(color: borderColor, height: 18),
                          _buildDetailBlock(
                            context: context,
                            icon: Icons.swap_horiz_rounded,
                            iconColor: Colors.orange,
                            label: "Direction",
                            value: transaction.transactionDirection.name,
                            textColor: textColor,
                            textMutedColor: textMutedColor,
                          ),
                          Divider(color: borderColor, height: 18),
                          _buildDetailBlock(
                            context: context,
                            icon: Icons.account_balance_wallet_rounded,
                            iconColor: Colors.teal,
                            label: "Type",
                            value: transaction.transactionType.name,
                            textColor: textColor,
                            textMutedColor: textMutedColor,
                          ),
                          Divider(color: borderColor, height: 18),
                          _buildDetailBlock(
                            context: context,
                            icon: Icons.calendar_month_rounded,
                            iconColor: Colors.indigo,
                            label: "Timestamp",
                            value: _formatDate(transaction.createdAt),
                            textColor: textColor,
                            textMutedColor: textMutedColor,
                          ),
                          if (transaction.note != null && transaction.note!.isNotEmpty) ...[
                            Divider(color: borderColor, height: 18),
                            _buildDetailBlock(
                              context: context,
                              icon: Icons.description_rounded,
                              iconColor: Colors.amber,
                              label: "Note / Description",
                              value: transaction.note!,
                              textColor: textColor,
                              textMutedColor: textMutedColor,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Floating App Bar (using shared backdrop-blurred AppbarComponent)
            AppbarComponent(
              positioned: true,
              top: 20.0, // Shifted down inside sheet header
              children: [
                const ApplicationBarDismissButtonComponent(),
                Text(
                  "Transaction Receipt",
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

            // 3. Bottom Share Receipt action (stretched to full width)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: SizedBox(
                width: double.infinity,
                child: StandardButtonComponent(
                  backgroundColor: ColorFactory.accentColor,
                  tapBackgroundColor: ColorFactory.accentColor.withAlpha(200),
                  onTap: () {
                    final isCredit = transaction.transactionDirection == TransactionMockDirection.CREDIT;
                    final directionText = isCredit ? "Received money from" : "Sent money to";
                    final amountText = "\$${transaction.amount.toStringAsFixed(2)}";
                    final dateText = _formatDate(transaction.createdAt);
                    final phone = transaction.secondaryUserPhoneNumber;

                    final shareText =
                        """
💙 VNote Transaction Receipt

${isCredit ? "✅ I received a payment from you." : "✅ I sent you a payment."}

📋 Transaction Details
━━━━━━━━━━━━━━━━━━
🔄 Action: $directionText
👤 ${isCredit ? "From" : "To"}: $phone
💵 Amount: $amountText
📅 Date: $dateText
🧾 Transaction ID: ${transaction.transactionId}

✨ Thanks for using VNote!
Fast • Secure • Simple 🚀
""";

                    ShareOptionsSheet.show(context, shareText);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.share_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      const StandardButtonText(text: "Share Receipt", foregroundColor: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBlock({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color textColor,
    required Color textMutedColor,
    bool useOswald = false,
  }) {
    final colorMode = context.read<GlobalColorModeControllerBloc>().state.colorMode;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colorMode == AppColorMode.LIGHT ? Colors.black.withAlpha(12) : Colors.white.withAlpha(12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: textMutedColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: useOswald
                    ? GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.w600, color: textColor)
                    : UIHelper.current.funnelTextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShareOptionsSheet extends StatelessWidget {
  final String shareText;

  const ShareOptionsSheet({super.key, required this.shareText});

  static void show(BuildContext context, String shareText) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareOptionsSheet(shareText: shareText),
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

    final cancelButtonBg = isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade300;
    final cancelButtonTapBg = isDark ? const Color(0xFF3A3A3C) : Colors.grey.shade400;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: MediaQuery.of(context).padding.bottom + 20),
      decoration: BoxDecoration(
        color: sheetBgColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4.5,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withAlpha(30) : Colors.black.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            "Share Receipt Options",
            textAlign: TextAlign.center,
            style: UIHelper.current.funnelTextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textColor),
          ),
          const SizedBox(height: 4),
          Text(
            "Choose a method to export this transaction receipt.",
            textAlign: TextAlign.center,
            style: UIHelper.current.funnelTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textMutedColor),
          ),
          const SizedBox(height: 20),

          // Options Container Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: innerCardBgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Column(
              children: [
                // Option 1: Copy to Clipboard
                _buildOptionTile(
                  context: context,
                  icon: Icons.content_copy_rounded,
                  iconColor: Colors.blue,
                  title: "Copy to Clipboard",
                  subtitle: "Copy formatted receipt text",
                  textColor: textColor,
                  textMutedColor: textMutedColor,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: shareText));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Receipt copied to clipboard!",
                          style: UIHelper.current.funnelTextStyle(color: Colors.white),
                        ),
                        backgroundColor: ColorFactory.accentColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                Divider(color: borderColor, height: 16),
                // Option 2: Share Externally
                _buildOptionTile(
                  context: context,
                  icon: Icons.ios_share_rounded,
                  iconColor: ColorFactory.accentColor,
                  title: "Share Externally",
                  subtitle: "Send via chat, email, or other apps",
                  textColor: textColor,
                  textMutedColor: textMutedColor,
                  onTap: () {
                    Navigator.pop(context);
                    // ignore: deprecated_member_use
                    Share.share(shareText);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Cancel Action button
          StandardButtonComponent(
            backgroundColor: cancelButtonBg,
            tapBackgroundColor: cancelButtonTapBg,
            borderRadius: 100,
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: double.infinity,
              child: StandardButtonText(text: "Cancel", foregroundColor: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color textMutedColor,
    required VoidCallback onTap,
  }) {
    final colorMode = context.read<GlobalColorModeControllerBloc>().state.colorMode;
    final isDark = colorMode == AppColorMode.DARK;

    return OnTapScaleInteractionComponent(
      config: OnTapScaleInteractionValue(initialScale: 0.98, finalScale: 1.0),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withAlpha(12) : Colors.black.withAlpha(12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textMutedColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: textMutedColor, size: 20),
          ],
        ),
      ),
    );
  }
}
