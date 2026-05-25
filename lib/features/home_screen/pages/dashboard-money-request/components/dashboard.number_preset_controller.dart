import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/constants/dashboard.money_request_constants.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/dashboard.request_money_screen.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardNumberPresetController extends StatelessWidget {
  final String currentValue;
  final void Function(String value) onPresetTap;

  const DashboardNumberPresetController({super.key, required this.currentValue, required this.onPresetTap});

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: DashboardMoneyRequestConstants.current.NUMBER_BUTTON_PRESETS.map((preset) {
          final isSelected = currentValue == preset.toString();
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onPresetTap(preset.toString()),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? ColorFactory.accentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isSelected ? ColorFactory.accentColor : Colors.grey.withAlpha(80),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  "₹$preset",
                  style: UIHelper.current.funnelTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : UIHelper.current.getValueAccordingToColorMode(
                            colorMode: globalColorModeBloc.state.colorMode,
                            darkValue: Colors.white.withAlpha(70),
                            lightValue: Colors.black.withAlpha(70),
                          ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
