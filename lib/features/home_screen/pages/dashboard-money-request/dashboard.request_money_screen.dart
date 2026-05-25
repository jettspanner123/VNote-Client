import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_button_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_preset_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/constants/dashboard.money_request_constants.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_counter_controller.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardRequestMoneyController extends StatefulWidget {
  const DashboardRequestMoneyController({super.key});

  @override
  State<DashboardRequestMoneyController> createState() => _DashboardRequestMoneyControllerState();
}

class _DashboardRequestMoneyControllerState extends State<DashboardRequestMoneyController>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  String enteredRequestMoneyValue = "0";

  void _onNumberButtonTap(String value) {
    setState(() {
      final backspace = DashboardMoneyRequestConstants.current.NUMBER_BUTTON_BACKSPACE_IDENTIFIER;
      if (value == backspace) {
        if (enteredRequestMoneyValue.length <= 1) {
          enteredRequestMoneyValue = "0";
        } else {
          enteredRequestMoneyValue = enteredRequestMoneyValue.substring(0, enteredRequestMoneyValue.length - 1);
        }
        return;
      }

      // Prevent multiple decimal points
      if (value == "." && enteredRequestMoneyValue.contains(".")) return;

      // Replace leading zero unless adding a decimal
      if (enteredRequestMoneyValue == "0" && value != ".") {
        enteredRequestMoneyValue = value;
      } else {
        enteredRequestMoneyValue += value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: const Cubic(0.85, 0, 0.15, 1)));

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Scaffold(
      backgroundColor: ColorFactory.accentColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarActionButton(
                    child: Icon(
                      Icons.close_rounded,
                      color: UIHelper.current.getValueAccordingToColorMode(
                        colorMode: globalColorModeBloc.state.colorMode,
                        darkValue: Colors.white,
                        lightValue: Colors.black,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Spacer(),
                  Text(
                    "Request Money",
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Spacer(),
                  Opacity(
                    opacity: 0,
                    child: AppbarActionButton(
                      child: Icon(
                        Icons.close_rounded,
                        color: UIHelper.current.getValueAccordingToColorMode(
                          colorMode: globalColorModeBloc.state.colorMode,
                          darkValue: Colors.white,
                          lightValue: Colors.black,
                        ),
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),

            // MARK: Main Content
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: UIHelper.current.getValueAccordingToColorMode(
                              colorMode: globalColorModeBloc.state.colorMode,
                              darkValue: ColorFactory.darkForegroundColor,
                              lightValue: Colors.white,
                            ),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                            child: Column(
                              children: [
                                DashboardNumberCounterController(enteredRequestMoneyValue: enteredRequestMoneyValue),
                                const SizedBox(height: 14),
                                DashboardNumberPresetController(
                                  currentValue: enteredRequestMoneyValue,
                                  onPresetTap: (value) => setState(() {
                                    enteredRequestMoneyValue = value;
                                  }),
                                ),
                                const SizedBox(height: 14),
                                DashboardNumberButtonController(onButtonTap: _onNumberButtonTap),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: StandardButtonComponent(
                                    tapBackgroundColor: Colors.white,
                                    backgroundColor: ColorFactory.accentColor,
                                    child: StandardButtonText(text: "Send Money"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
}
