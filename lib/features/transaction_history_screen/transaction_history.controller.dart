import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard/components/fragments/dashboard.transaction_tile.dart';
import 'package:vnote_client/shared/components/others/date_range_picker_sheet.dart';
import 'package:vnote_client/models/mock/transaction_mock_model.dart';
import 'package:vnote_client/services/mock_data_service.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
import 'package:vnote_client/shared/components/text/secondary_section_header_component.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = const [
    'All',
    'Last 24 Hours',
    'Past 7 Days',
    'Past 30 Days',
    'Credits',
    'Debits',
  ];

  bool _filterTransaction(TransactionMockModel transaction) {
    if (_selectedFilter == 'All') return true;

    final now = DateTime.now();
    final difference = now.difference(transaction.createdAt);

    switch (_selectedFilter) {
      case 'Last 24 Hours':
        return difference.inHours <= 24;
      case 'Past 7 Days':
        return difference.inDays <= 7;
      case 'Past 30 Days':
        return difference.inDays <= 30;
      case 'Credits':
        return transaction.transactionDirection == TransactionMockDirection.CREDIT;
      case 'Debits':
        return transaction.transactionDirection == TransactionMockDirection.DEBIT;
      default:
        return true;
    }
  }

  Widget _buildFilterChip(String label, AppColorMode colorMode) {
    final isSelected = _selectedFilter == label;
    final textStyle = UIHelper.current.funnelTextStyle(
      fontSize: 14.5,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
      color: isSelected 
          ? Colors.white 
          : UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(150),
    );

    return OnTapScaleInteractionComponent(
      config: OnTapScaleInteractionValue(
        initialScale: 0.95, 
        finalScale: 1.0, 
        duration: const Duration(milliseconds: 100),
      ),
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? ColorFactory.accentColor 
              : UIHelper.current.getForegroundColorForColorMode(colorMode),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected 
                ? Colors.transparent 
                : colorMode == AppColorMode.LIGHT 
                    ? Colors.black.withAlpha(20) 
                    : Colors.white.withAlpha(20),
            width: 0.8,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: ColorFactory.accentColor.withAlpha(40),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ] : [],
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }

  Widget _buildFloatingActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
    required AppColorMode colorMode,
  }) {
    final backgroundColor = isPrimary 
        ? ColorFactory.accentColor 
        : UIHelper.current.getForegroundColorForColorMode(colorMode);
    final textColor = isPrimary 
        ? Colors.white 
        : UIHelper.current.getTextColorForColorMode(colorMode);
    final borderColor = isPrimary 
        ? Colors.transparent 
        : colorMode == AppColorMode.LIGHT 
            ? Colors.black.withAlpha(20) 
            : Colors.white.withAlpha(20);

    return OnTapScaleInteractionComponent(
      config: OnTapScaleInteractionValue(
        initialScale: 0.95, 
        finalScale: 1.0, 
        duration: const Duration(milliseconds: 100),
      ),
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: (isPrimary ? ColorFactory.accentColor : Colors.black).withAlpha(isPrimary ? 30 : 15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: UIHelper.current.funnelTextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    UIHelper.current.setStatusBarColors(colorMode);

    final allTransactions = List<TransactionMockModel>.from(
      MockDataService.current.RECENT_TRANSACTIONS,
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final filteredTransactions = allTransactions.where(_filterTransaction).toList();

    // Aggregate statistics for the currently filtered subset
    double totalAmount = 0;
    double creditAmount = 0;
    double debitAmount = 0;

    for (var tx in filteredTransactions) {
      totalAmount += tx.amount;
      if (tx.transactionDirection == TransactionMockDirection.CREDIT) {
        creditAmount += tx.amount;
      } else {
        debitAmount += tx.amount;
      }
    }

    final ratio = totalAmount > 0 ? creditAmount / totalAmount : 0.5;

    final cardBgColor = UIHelper.current.getForegroundColorForColorMode(colorMode);
    final borderColor = colorMode == AppColorMode.DARK 
        ? Colors.white.withAlpha(20) 
        : Colors.black.withAlpha(20);
    final textMutedColor = UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(120);

    return Scaffold(
      backgroundColor: UIHelper.current.getBackgroundColorForColorMode(colorMode),
      body: Stack(
        children: [
          // Scrollable content underneath the floating appbar
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.only(
                top: 120, // Prevents content from rendering under the floating app bar
                bottom: 120, // Extra bottom padding so list scrolls fully above floating buttons
              ),
              children: [
                // Compact Dynamic Volume Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_selectedFilter.toUpperCase()} VOLUME",
                        style: UIHelper.current.funnelTextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: textMutedColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.oswald(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: UIHelper.current.getTextColorForColorMode(colorMode),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Graphic proportion indicator bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 10,
                          width: double.infinity,
                          child: totalAmount == 0
                              ? Container(
                                  color: colorMode == AppColorMode.DARK 
                                      ? Colors.white.withAlpha(20) 
                                      : Colors.black.withAlpha(10),
                                )
                              : Row(
                                  children: [
                                    if (creditAmount > 0)
                                      Expanded(
                                        flex: (ratio * 100).toInt().clamp(1, 99),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF34D399), Color(0xFF10B981)],
                                            ),
                                            borderRadius: creditAmount > 0 && debitAmount > 0
                                                ? const BorderRadius.only(
                                                    topLeft: Radius.circular(100),
                                                    bottomLeft: Radius.circular(100),
                                                  )
                                                : BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                    if (creditAmount > 0 && debitAmount > 0)
                                      const SizedBox(width: 3.5),
                                    if (debitAmount > 0)
                                      Expanded(
                                        flex: ((1.0 - ratio) * 100).toInt().clamp(1, 99),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFEF4444), Color(0xFFF87171)],
                                            ),
                                            borderRadius: creditAmount > 0 && debitAmount > 0
                                                ? const BorderRadius.only(
                                                    topRight: Radius.circular(100),
                                                    bottomRight: Radius.circular(100),
                                                  )
                                                : BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Side-by-side Credit and Debit breakdown amounts with percentage badges
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF10B981)),
                              const SizedBox(width: 6),
                              Text(
                                "Credit: \$${creditAmount.toStringAsFixed(2)}",
                                style: UIHelper.current.funnelTextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withAlpha(25),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "${(ratio * 100).toStringAsFixed(0)}%",
                                  style: UIHelper.current.funnelTextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF10B981),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const CircleAvatar(radius: 3.5, backgroundColor: Color(0xFFEF4444)),
                              const SizedBox(width: 6),
                              Text(
                                "Debit: \$${debitAmount.toStringAsFixed(2)}",
                                style: UIHelper.current.funnelTextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFEF4444),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withAlpha(25),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "${((1.0 - ratio) * 100).toStringAsFixed(0)}%",
                                  style: UIHelper.current.funnelTextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFFEF4444),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: SecondarySectionHeaderComponent(text: "Filters"),
                ),

                // Horizontally Scrollable Filters List (Edge-to-edge scrolling)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    spacing: 8,
                    children: _filters.map((filter) => _buildFilterChip(filter, colorMode)).toList(),
                  ),
                ),
                const SizedBox(height: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SecondarySectionHeaderComponent(text: "Transactions"),
                ),
                const SizedBox(height: 8),

                // Transactions Cards List
                if (filteredTransactions.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
                      child: Text(
                        "No transactions found for this filter.",
                        style: UIHelper.current.funnelTextStyle(
                          fontSize: 15,
                          color: UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(100),
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: filteredTransactions.map(
                        (transaction) => DashboardTransactionCardComponent(transaction: transaction),
                      ).toList(),
                    ),
                  ),
              ],
            ),
          ),

          // Floating App Bar containing Heading and the Back Action Button
          AppbarComponent(
            children: [
              const ApplicationBarBackButtonComponent(),
              Text(
                "Transactions",
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: UIHelper.current.getTextColorForColorMode(colorMode),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 50), // Balance the 50px width of the back button to center the title
            ],
          ),

          // Bottom Floating Action Button Row (Get Receipt only, primary green button)
          Positioned(
            bottom: 25,
            left: 15,
            right: 15,
            child: _buildFloatingActionButton(
              label: "Get Receipt",
              icon: Icons.receipt_long_rounded,
              isPrimary: true,
              colorMode: colorMode,
              onTap: () {
                DateRangePickerSheet.show(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
