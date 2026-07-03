import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';
import 'package:vnote_client/shared/components/others/custom_date_picker.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DateRangePickerSheet extends StatefulWidget {
  const DateRangePickerSheet({super.key});

  static Future<DateTimeRange?> show(BuildContext context) {
    return showGeneralDialog<DateTimeRange>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Date Range Dialog",
      barrierColor: Colors.black.withAlpha(220),
      transitionDuration: const Duration(milliseconds: 375),
      pageBuilder: (context, animation, secondaryAnimation) => const DateRangePickerSheet(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curve),
          child: child,
        );
      },
    );
  }

  @override
  State<DateRangePickerSheet> createState() => _DateRangePickerSheetState();
}

class _DateRangePickerSheetState extends State<DateRangePickerSheet> with TickerProviderStateMixin {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  // Validation State Variables
  bool _fromDateError = false;
  bool _toDateError = false;
  bool _downloadButtonError = false;

  // Shake Animation Controllers
  late AnimationController _fromShakeController;
  late AnimationController _toShakeController;

  @override
  void initState() {
    super.initState();
    _fromShakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
    _toShakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await CustomDatePicker.show(
      context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
        _fromDateController.text = _formatDate(picked);
        _fromDateError = false; // Revert red styling immediately on valid input
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await CustomDatePicker.show(
      context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: _fromDate ?? DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _toDate = picked;
        _toDateController.text = _formatDate(picked);
        _toDateError = false; // Revert red styling immediately on valid input
      });
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _fromShakeController.dispose();
    _toShakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;
    final isDark = colorMode == AppColorMode.DARK;

    final sheetBgColor = isDark ? const Color(0xFF1C1C1E) : Colors.grey.shade50;
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final textMutedColor = textColor.withAlpha(120);

    final cancelButtonBg = isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade300;
    final cancelButtonTapBg = isDark ? const Color(0xFF3A3A3C) : Colors.grey.shade400;

    // Turn button red on error, otherwise use standard green accent color
    final downloadButtonBg = _downloadButtonError ? Colors.redAccent : ColorFactory.accentColor;
    final downloadButtonTapBg = _downloadButtonError
        ? Colors.redAccent.withAlpha(200)
        : ColorFactory.accentColor.withAlpha(200);

    // Uniform border radius of 24 to match standard button components perfectly
    const double uniformBorderRadius = 24.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: Theme.of(context).copyWith(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primaryColor: ColorFactory.accentColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor, displayColor: textColor),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorFactory.accentColor,
            selectionColor: ColorFactory.accentColor.withAlpha(80),
            selectionHandleColor: ColorFactory.accentColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. The Main Input Form Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: sheetBgColor,
                borderRadius: BorderRadius.circular(uniformBorderRadius),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  Text(
                    "Select Receipt Range",
                    textAlign: TextAlign.center,
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Choose a start and end date to export transaction history.",
                    textAlign: TextAlign.center,
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: textMutedColor,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // From Date Label & Input wrapped in a premium Side-to-Side Shake Transition
                  ShakeWidget(
                    animation: _fromShakeController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StandardInputLabelComponent(
                          text: "From Date",
                          secondaryText: "Start date of transactions",
                          foregroundColor: _fromDateError ? Colors.redAccent : textColor,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectFromDate(context),
                          behavior: HitTestBehavior.opaque,
                          child: AbsorbPointer(
                            child: StandardInputField(
                              textController: _fromDateController,
                              placeholder: "Select start date",
                              borderColor: _fromDateError ? Colors.redAccent : textColor.withAlpha(100),
                              placeholderTextColor: textMutedColor,
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: _fromDateError ? Colors.redAccent : textMutedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // To Date Label & Input wrapped in a premium Side-to-Side Shake Transition
                  ShakeWidget(
                    animation: _toShakeController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StandardInputLabelComponent(
                          text: "To Date",
                          secondaryText: "End date of transactions",
                          foregroundColor: _toDateError ? Colors.redAccent : textColor,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _selectToDate(context),
                          behavior: HitTestBehavior.opaque,
                          child: AbsorbPointer(
                            child: StandardInputField(
                              textController: _toDateController,
                              placeholder: "Select end date",
                              borderColor: _toDateError ? Colors.redAccent : textColor.withAlpha(100),
                              placeholderTextColor: textMutedColor,
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: _toDateError ? Colors.redAccent : textMutedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), // Space between inputs card and floating action buttons

            // 2. The Floating Action Buttons Row (just below the inputs card)
            Row(
              children: [
                Expanded(
                  child: StandardButtonComponent(
                    backgroundColor: cancelButtonBg,
                    tapBackgroundColor: cancelButtonTapBg,
                    borderRadius: uniformBorderRadius,
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      width: double.infinity,
                      child: StandardButtonText(text: "Cancel", foregroundColor: textColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StandardButtonComponent(
                    backgroundColor: downloadButtonBg,
                    tapBackgroundColor: downloadButtonTapBg,
                    borderRadius: uniformBorderRadius,
                    onTap: () {
                      final hasFromError = _fromDate == null;
                      final hasToError = _toDate == null;

                      if (hasFromError || hasToError) {
                        setState(() {
                          _fromDateError = hasFromError;
                          _toDateError = hasToError;
                          _downloadButtonError = true;
                        });

                        // Shake invalid inputs
                        if (hasFromError) {
                          _fromShakeController.forward(from: 0.0);
                        }
                        if (hasToError) {
                          _toShakeController.forward(from: 0.0);
                        }

                        // Revert download button color after 1.5 seconds
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          if (mounted) {
                            setState(() {
                              _downloadButtonError = false;
                            });
                          }
                        });

                        HapticFeedback.lightImpact();
                        return;
                      }

                      // Successfully completed validation
                      Navigator.pop(
                        context,
                        DateTimeRange(start: _fromDate!, end: _toDate!),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Download",
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.download_rounded, color: Colors.white, size: 19),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable widget to play a dynamic side-to-side shift (shake) animation
class ShakeWidget extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const ShakeWidget({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // High quality decaying sine wave shake offset
        final double offset = sin(animation.value * pi * 3.5) * 8.0 * (1.0 - animation.value);
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
