import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/component_constants.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/views/dashboard.request_money_create_user_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/views/dashboard.request_money_payment_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/views/dashboard.request_money_select_user_controller.dart';
import 'package:vnote_client/shared/animations/circle_reveal_route_animation.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';
import 'package:vnote_client/shared/views/money_sent_or_requested_successfully_component.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/utils/ui_helper.dart';

enum DashboardRequestMoneyScreenState { ENTER_PAYMENT_DETAILS, SELECT_USER, CREATE_USER }

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
  DashboardRequestMoneyScreenState currentScreenState = DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS;
  final GlobalKey _fabKey = GlobalKey();

  Offset _getFabCenter() {
    final box = _fabKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return Offset.zero;
    final position = box.localToGlobal(Offset.zero);
    return position + Offset(box.size.width / 2, box.size.height / 2);
  }

  void _goTo(DashboardRequestMoneyScreenState next) {
    setState(() => currentScreenState = next);
  }

  void _handleFloatingActionButtonTap() {
    if (currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS) {
      _goTo(DashboardRequestMoneyScreenState.SELECT_USER);
    } else if (currentScreenState == DashboardRequestMoneyScreenState.SELECT_USER) {
      final center = _getFabCenter();
      Navigator.of(context).push(
        CircularRevealRoute(
          originCenter: center,
          builder: (_) => const MoneySentOrRequestedSuccessfullyComponent(
            moneyFlowDirection: MoneySentOrRequestedSuccessfullyFlowDirection.REQUESTED,
          ),
        ),
      );
    }
  }

  void _handleCreateUserTap() {
    if (DashboardRequestMoneyScreenState.SELECT_USER != currentScreenState) return;
    setState(() {
      currentScreenState = DashboardRequestMoneyScreenState.CREATE_USER;
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
                      currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS
                          ? Icons.close_rounded
                          : Icons.chevron_left,
                      color: UIHelper.current.getValueAccordingToColorMode(
                        colorMode: globalColorModeBloc.state.colorMode,
                        darkValue: Colors.white,
                        lightValue: Colors.black,
                      ),
                    ),
                    onTap: () => {
                      if (currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS)
                        Navigator.of(context).pop()
                      else
                        _goTo(DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS),
                    },
                  ),
                  Spacer(),
                  Text(
                    currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS
                        ? "Request Money"
                        : currentScreenState == DashboardRequestMoneyScreenState.SELECT_USER
                        ? "Select Person"
                        : "Create User",
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Spacer(),
                  Opacity(
                    opacity: currentScreenState == DashboardRequestMoneyScreenState.SELECT_USER ? 1 : 0,
                    child: AppbarActionButton(
                      onTap: _handleCreateUserTap,
                      child: Transform.scale(
                        scale: 0.9,
                        child: Icon(
                          Icons.person_add,
                          color: UIHelper.current.getValueAccordingToColorMode(
                            colorMode: globalColorModeBloc.state.colorMode,
                            darkValue: Colors.white,
                            lightValue: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // MARK: Main Content
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
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
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS
                                ? DashboardRequestMoneyPaymentController(
                                    key: const ValueKey(DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS),
                                    initialValue: enteredRequestMoneyValue,
                                    selectUserButtonAction: () => _goTo(DashboardRequestMoneyScreenState.SELECT_USER),
                                    onValueChanged: (value) => enteredRequestMoneyValue = value,
                                  )
                                : currentScreenState == DashboardRequestMoneyScreenState.SELECT_USER
                                ? DashboardRequestMoneySelectUserController(
                                    key: const ValueKey(DashboardRequestMoneyScreenState.SELECT_USER),
                                  )
                                : DashboardRequestMoneyCreateUserController(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: ComponentConstants.screenHorizontalPadding,
          child: SizedBox(
            width: double.infinity,
            child: StandardButtonComponent(
              key: _fabKey,
              onTap: _handleFloatingActionButtonTap,
              backgroundColor: ColorFactory.accentColor,
              tapBackgroundColor: Colors.black,
              child: StandardButtonText(
                text: currentScreenState == DashboardRequestMoneyScreenState.ENTER_PAYMENT_DETAILS
                    ? "Proceed"
                    : "Request Money",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
