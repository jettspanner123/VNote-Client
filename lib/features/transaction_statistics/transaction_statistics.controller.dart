import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/models/mock/transaction_mock_model.dart';
import 'package:vnote_client/services/mock_data_service.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class TransactionStatisticsScreen extends StatefulWidget {
  const TransactionStatisticsScreen({super.key});

  @override
  State<TransactionStatisticsScreen> createState() => _TransactionStatisticsScreenState();
}

class _TransactionStatisticsScreenState extends State<TransactionStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    UIHelper.current.setStatusBarColors(colorMode);

    // Fetch and aggregate transaction details
    final allTransactions = MockDataService.current.RECENT_TRANSACTIONS;
    double totalCredits = 0;
    double totalDebits = 0;

    for (var tx in allTransactions) {
      if (tx.transactionDirection == TransactionMockDirection.CREDIT) {
        totalCredits += tx.amount;
      } else {
        totalDebits += tx.amount;
      }
    }

    final totalBalance = totalCredits - totalDebits;
    final totalTurnover = totalCredits + totalDebits;
    final creditRatio = totalTurnover > 0 ? totalCredits / totalTurnover : 0.5;

    // Card background & borders helper
    final cardBgColor = UIHelper.current.getForegroundColorForColorMode(colorMode);
    final borderColor = colorMode == AppColorMode.LIGHT 
        ? Colors.black.withAlpha(20) 
        : Colors.white.withAlpha(20);
    final textMutedColor = UIHelper.current.getTextColorForColorMode(colorMode).withAlpha(120);

    return Scaffold(
      backgroundColor: UIHelper.current.getBackgroundColorForColorMode(colorMode),
      body: Stack(
        children: [
          // Scrollable layout contents
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.only(
                top: 120, // Prevents content from rendering under the floating app bar
                left: 15,
                right: 15,
                bottom: 40,
              ),
              children: [
                // 1. Borderless Focal Summary Block (Variation & High Compactness)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "NET BALANCE",
                              style: UIHelper.current.funnelTextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: textMutedColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${totalBalance.toStringAsFixed(2)}",
                              style: GoogleFonts.oswald(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: UIHelper.current.getTextColorForColorMode(colorMode),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Income & Expense indicators row
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 3.5,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Income", style: UIHelper.current.funnelTextStyle(fontSize: 11, color: textMutedColor, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 1),
                                    Text(
                                      "\$${totalCredits.toStringAsFixed(2)}", 
                                      style: GoogleFonts.oswald(
                                        fontSize: 15, 
                                        fontWeight: FontWeight.w600, 
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(height: 22, width: 1, color: borderColor),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Expenses", style: UIHelper.current.funnelTextStyle(fontSize: 11, color: textMutedColor, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 1),
                                    Text(
                                      "\$${totalDebits.toStringAsFixed(2)}", 
                                      style: GoogleFonts.oswald(
                                        fontSize: 15, 
                                        fontWeight: FontWeight.w600, 
                                        color: const Color(0xFFEF4444),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 3.5,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Flow Proportion progress line directly sitting below it
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 6,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: (creditRatio * 100).toInt(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [Color(0xFF34D399), Color(0xFF10B981)]),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2.5),
                              Expanded(
                                flex: ((1.0 - creditRatio) * 100).toInt(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFF87171)]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "In: ",
                                style: UIHelper.current.funnelTextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMutedColor),
                              ),
                              Text(
                                "${(creditRatio * 100).toStringAsFixed(0)}%",
                                style: GoogleFonts.oswald(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF10B981)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Out: ",
                                style: UIHelper.current.funnelTextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMutedColor),
                              ),
                              Text(
                                "${((1.0 - creditRatio) * 100).toStringAsFixed(0)}%",
                                style: GoogleFonts.oswald(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFFEF4444)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // 2. Weekly Cash Flow Chart Card (Compact grouped columns layout)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Weekly Cash Flow",
                            style: UIHelper.current.funnelTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: UIHelper.current.getTextColorForColorMode(colorMode),
                            ),
                          ),
                          // Compact Legend
                          Row(
                            children: [
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              Text("In", style: UIHelper.current.funnelTextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textMutedColor)),
                              const SizedBox(width: 8),
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              Text("Out", style: UIHelper.current.funnelTextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textMutedColor)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Interactive grouped columns chart (compact grouped bars layout)
                      SizedBox(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildGroupedChartBar("Mon", 0.65, 0.35),
                            _buildGroupedChartBar("Tue", 0.40, 0.55),
                            _buildGroupedChartBar("Wed", 0.80, 0.25),
                            _buildGroupedChartBar("Thu", 0.35, 0.50),
                            _buildGroupedChartBar("Fri", 0.90, 0.75),
                            _buildGroupedChartBar("Sat", 0.50, 0.20),
                            _buildGroupedChartBar("Sun", 0.70, 0.30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Floating App Bar containing Heading and the Back Action Button
          AppbarComponent(
            children: [
              const ApplicationBarBackButtonComponent(),
              Text(
                "Statistics",
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
        ],
      ),
    );
  }

  Widget _buildGroupedChartBar(String dayLabel, double creditRatio, double debitRatio) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Income Column
              Container(
                width: 8,
                height: 100 * creditRatio,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34D399), Color(0xFF10B981)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(width: 2),
              // Expense Column
              Container(
                width: 8,
                height: 100 * debitRatio,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF87171), Color(0xFFEF4444)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          dayLabel,
          style: UIHelper.current.funnelTextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
