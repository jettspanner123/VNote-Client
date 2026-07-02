import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/models/mock/transaction_mock_model.dart';
import 'package:vnote_client/shared/components/others/transaction_detail_sheet.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardTransactionCardComponent extends StatelessWidget {
  final TransactionMockModel transaction;

  const DashboardTransactionCardComponent({super.key, required this.transaction});

  String _formatAmount(double amount) {
    final prefix = transaction.transactionDirection == TransactionMockDirection.CREDIT ? '+' : '-';
    return '$prefix\$${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, $hour:$minute $period';
  }

  IconData _directionIcon(TransactionMockDirection direction) {
    return direction == TransactionMockDirection.CREDIT ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    final isCredit = transaction.transactionDirection == TransactionMockDirection.CREDIT;
    final amountColor = isCredit
        ? const Color(0xFF10B981) // Vibrant emerald green for credits
        : const Color(0xFFEF4444); // Modern coral red for debits

    return OnTapScaleInteractionComponent(
      config: OnTapScaleInteractionValue(
        initialScale: 0.98,
        finalScale: 1.0,
        duration: const Duration(milliseconds: 100),
      ),
      onTap: () {
        TransactionDetailSheet.show(context, transaction);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: UIHelper.current.getForegroundColorForColorMode(colorMode),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorMode == AppColorMode.LIGHT ? Colors.black.withAlpha(15) : Colors.white.withAlpha(15),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(colorMode == AppColorMode.LIGHT ? 6 : 15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Circular Direction Icon Container (Muted, theme-aware background and icon)
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: colorMode == AppColorMode.LIGHT 
                    ? Colors.black.withAlpha(12) 
                    : Colors.white.withAlpha(12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _directionIcon(transaction.transactionDirection), 
                color: UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(150), 
                size: 18,
              ),
            ),

            const SizedBox(width: 12),

            // User Phone Number & Transaction Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    transaction.secondaryUserPhoneNumber,
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: UIHelper.current.getTextColorForColorMode(colorMode),
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _formatDate(transaction.createdAt),
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(120),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Right Side: Amount
            Text(
              _formatAmount(transaction.amount),
              style: UIHelper.current.funnelTextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: amountColor),
            ),
          ],
        ),
      ),
    );
  }
}
