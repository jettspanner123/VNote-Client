import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

import '../../../../../../constants/color_factory.dart';
import '../../../../../../shared/interaction/tap_scale_interaction.dart';
import '../../../../../../utils/ui_helper.dart';
import '../../../dashboard-money-request/dashboard.request_money_screen.dart';
import '../../../dashboard-money-transfer/dashboard.transfer_money_screen.dart';
import '../../../../../../shared/animations/circle_reveal_route_animation.dart';

// ---------------------------------------------------------------------------
// Helper: get the center of a widget in global (screen) coordinates
// ---------------------------------------------------------------------------

Offset _getWidgetCenter(GlobalKey key) {
  final box = key.currentContext?.findRenderObject() as RenderBox?;
  if (box == null) return Offset.zero;
  final position = box.localToGlobal(Offset.zero);
  return position + Offset(box.size.width / 2, box.size.height / 2);
}

// ---------------------------------------------------------------------------
// Main widget
// ---------------------------------------------------------------------------

class DashboardMainContentActionButtonsController extends StatefulWidget {
  const DashboardMainContentActionButtonsController({super.key});

  @override
  State<DashboardMainContentActionButtonsController> createState() =>
      _DashboardMainContentActionButtonsControllerState();
}

class _DashboardMainContentActionButtonsControllerState extends State<DashboardMainContentActionButtonsController> {
  final GlobalKey _requestButtonKey = GlobalKey();
  final GlobalKey _transferButtonKey = GlobalKey();

  void _openRequestOverlay() {
    final center = _getWidgetCenter(_requestButtonKey);
    Navigator.of(
      context,
    ).push(CircularRevealRoute(originCenter: center, builder: (_) => const DashboardRequestMoneyController()));
  }

  void _openTransferOverlay() {
    final center = _getWidgetCenter(_transferButtonKey);
    Navigator.of(
      context,
    ).push(CircularRevealRoute(originCenter: center, builder: (_) => const DashboardTransferMoneyController()));
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    return Row(
      spacing: 5,
      children: [
        // ── Request button ──────────────────────────────────────
        Expanded(
          child: OnTapScaleInteractionComponent(
            config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
            onTap: _openRequestOverlay,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: UIHelper.current.getValueAccordingToColorMode(
                  colorMode: globalColorModeBloc.state.colorMode,
                  darkValue: ColorFactory.darkForegroundColor,
                  lightValue: Colors.white,
                ),
                borderRadius: BorderRadius.circular(100),
                border: UIHelper.current.getDefaultBorder(colorMode: globalColorModeBloc.state.colorMode),
                boxShadow: [UIHelper.current.getDefaultBoxShadow()],
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        key: _requestButtonKey,
                        decoration: BoxDecoration(
                          color: ColorFactory.accentColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(Icons.call_received_rounded, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorModeAwareTextComponent(
                            text: "Request",
                            style: UIHelper.current.funnelTextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // ── Transfer button ─────────────────────────────────────
        Expanded(
          child: OnTapScaleInteractionComponent(
            config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1),
            onTap: _openTransferOverlay,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: UIHelper.current.getValueAccordingToColorMode(
                  colorMode: globalColorModeBloc.state.colorMode,
                  darkValue: ColorFactory.darkForegroundColor,
                  lightValue: Colors.white,
                ),
                borderRadius: BorderRadius.circular(100),
                border: UIHelper.current.getDefaultBorder(colorMode: globalColorModeBloc.state.colorMode),
                boxShadow: [UIHelper.current.getDefaultBoxShadow()],
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        key: _transferButtonKey,
                        decoration: BoxDecoration(
                          color: ColorFactory.accentColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(Icons.arrow_outward_rounded, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorModeAwareTextComponent(
                            text: "Transfer",
                            style: UIHelper.current.funnelTextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
