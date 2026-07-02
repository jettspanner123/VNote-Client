import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    return showGeneralDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Date Picker",
      barrierColor: Colors.black.withAlpha(220),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim1, anim2) => CustomDatePicker(
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(curve),
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  late int _viewedMonth;
  late int _viewedYear;
  bool _showMonthYearPicker = false;

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _viewedMonth = _selectedDate.month;
    _viewedYear = _selectedDate.year;
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _getFirstWeekdayOfMonth(int year, int month) {
    // Return Sunday-first index: Sunday=0, Monday=1, ... Saturday=6
    final int weekday = DateTime(year, month, 1).weekday;
    return weekday == 7 ? 0 : weekday;
  }

  List<DateTime> _generateCalendarDays() {
    final int daysInMonth = _getDaysInMonth(_viewedYear, _viewedMonth);
    final int firstWeekday = _getFirstWeekdayOfMonth(_viewedYear, _viewedMonth);

    final List<DateTime> daysList = [];

    // Generate padding from previous month
    final DateTime prevMonth = DateTime(_viewedYear, _viewedMonth - 1);
    final int daysInPrevMonth = _getDaysInMonth(prevMonth.year, prevMonth.month);
    for (int i = firstWeekday - 1; i >= 0; i--) {
      daysList.add(DateTime(prevMonth.year, prevMonth.month, daysInPrevMonth - i));
    }

    // Generate days of current month
    for (int i = 1; i <= daysInMonth; i++) {
      daysList.add(DateTime(_viewedYear, _viewedMonth, i));
    }

    // Generate padding for next month to form a complete 6-row grid
    final int remaining = 42 - daysList.length;
    final DateTime nextMonth = DateTime(_viewedYear, _viewedMonth + 1);
    for (int i = 1; i <= remaining; i++) {
      daysList.add(DateTime(nextMonth.year, nextMonth.month, i));
    }

    return daysList;
  }

  void _goToPreviousMonth() {
    setState(() {
      if (_viewedMonth == 1) {
        _viewedMonth = 12;
        _viewedYear--;
      } else {
        _viewedMonth--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (_viewedMonth == 12) {
        _viewedMonth = 1;
        _viewedYear++;
      } else {
        _viewedMonth++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;
    final isDark = colorMode == AppColorMode.DARK;

    final dialogBg = isDark ? const Color(0xFF1C1C1E) : Colors.grey.shade50;
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final textMutedColor = textColor.withAlpha(120);

    final cancelButtonBg = isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade300;
    final cancelButtonTapBg = isDark ? const Color(0xFF3A3A3C) : Colors.grey.shade400;

    final List<DateTime> calendarDays = _generateCalendarDays();
    final String currentMonthName = _months[_viewedMonth - 1];

    // Uniform border radius of 24 to match standard button components perfectly
    const double uniformBorderRadius = 24.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. The Main Input Form Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: dialogBg,
              borderRadius: BorderRadius.circular(uniformBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Month & Year Selector Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left_rounded, color: textColor),
                      onPressed: _showMonthYearPicker ? null : _goToPreviousMonth,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMonthYearPicker = !_showMonthYearPicker;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "$currentMonthName $_viewedYear",
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            _showMonthYearPicker ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                            color: ColorFactory.accentColor,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right_rounded, color: textColor),
                      onPressed: _showMonthYearPicker ? null : _goToNextMonth,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Animated Swapper between standard Grid and Quick Month/Year selectors
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _showMonthYearPicker
                      ? _buildMonthYearPickerView(textColor, isDark)
                      : Column(
                          key: ValueKey("grid_view_$_viewedMonth"),
                          children: [
                            // Weekday labels
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: _weekdays.map((day) {
                                return SizedBox(
                                  width: 36,
                                  child: Text(
                                    day,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.funnelDisplay(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: textMutedColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),

                            // 7x6 Days Grid
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: calendarDays.length,
                              itemBuilder: (context, index) {
                                final date = calendarDays[index];
                                final isCurrentMonth = date.month == _viewedMonth && date.year == _viewedYear;
                                final isSelected = date.day == _selectedDate.day &&
                                    date.month == _selectedDate.month &&
                                    date.year == _selectedDate.year;

                                final isToday = date.day == DateTime.now().day &&
                                    date.month == DateTime.now().month &&
                                    date.year == DateTime.now().year;

                                Color cellTextCol = textColor;
                                if (!isCurrentMonth) {
                                  cellTextCol = textMutedColor.withAlpha(80);
                                }
                                if (isSelected) {
                                  cellTextCol = Colors.white;
                                }

                                // Block dates outside limits
                                final bool isDisabled = date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate);

                                return GestureDetector(
                                  onTap: isDisabled
                                      ? null
                                      : () {
                                          HapticFeedback.lightImpact();
                                          setState(() {
                                            _selectedDate = date;
                                          });
                                        },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? ColorFactory.accentColor
                                          : isToday
                                              ? ColorFactory.accentColor.withAlpha(20)
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: isToday
                                          ? Border.all(color: ColorFactory.accentColor.withAlpha(100), width: 1)
                                          : null,
                                    ),
                                    alignment: Alignment.center,
                                    child: Opacity(
                                      opacity: isDisabled ? 0.3 : 1.0,
                                      child: Text(
                                        "${date.day}",
                                        style: GoogleFonts.funnelDisplay(
                                          fontSize: 14,
                                          fontWeight: isSelected || isToday ? FontWeight.w800 : FontWeight.w600,
                                          color: cellTextCol,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Space between calendar card and floating action buttons

          // 2. The Floating Action Buttons Row (just below the inputs card)
          Row(
            children: [
              Expanded(
                child: StandardButtonComponent(
                  backgroundColor: cancelButtonBg,
                  tapBackgroundColor: cancelButtonTapBg,
                  borderRadius: uniformBorderRadius,
                  onTap: () => Navigator.pop(context, null),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: StandardButtonText(
                        text: "Cancel",
                        foregroundColor: textColor,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StandardButtonComponent(
                  backgroundColor: ColorFactory.accentColor,
                  tapBackgroundColor: ColorFactory.accentColor.withAlpha(200),
                  borderRadius: uniformBorderRadius,
                  onTap: () => Navigator.pop(context, _selectedDate),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: StandardButtonText(
                        text: "Select",
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Quick Month/Year select scroll/selector view
  Widget _buildMonthYearPickerView(Color textColor, bool isDark) {
    return SizedBox(
      height: 240,
      child: Row(
        children: [
          // Month Selector Column
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _months.length,
              itemBuilder: (context, index) {
                final isCurrent = index + 1 == _viewedMonth;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _viewedMonth = index + 1;
                      _showMonthYearPicker = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isCurrent ? ColorFactory.accentColor.withAlpha(30) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _months[index],
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                        color: isCurrent ? ColorFactory.accentColor : textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const VerticalDivider(width: 16),
          // Year Selector Column
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.lastDate.year - widget.firstDate.year + 1,
              itemBuilder: (context, index) {
                final year = widget.firstDate.year + index;
                final isCurrent = year == _viewedYear;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _viewedYear = year;
                      _showMonthYearPicker = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isCurrent ? ColorFactory.accentColor.withAlpha(30) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$year",
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                        color: isCurrent ? ColorFactory.accentColor : textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
