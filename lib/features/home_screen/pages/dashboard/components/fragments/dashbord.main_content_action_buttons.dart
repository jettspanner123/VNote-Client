import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/shared/components/text/section_heading_component.dart';

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
  bool _showMoreOptions = false;

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

  Widget _buildMoreOptionsToggle(AppColorMode colorMode) {
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 2),
      child: OnTapScaleInteractionComponent(
        config: OnTapScaleInteractionValue(initialScale: 0.98, finalScale: 1.0),
        onTap: () {
          setState(() {
            _showMoreOptions = !_showMoreOptions;
          });
        },
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: colorMode == AppColorMode.DARK 
                ? Colors.white.withAlpha(15) 
                : Colors.black.withAlpha(8),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _showMoreOptions ? "Less Options" : "More Options",
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textColor.withAlpha(190),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                _showMoreOptions 
                    ? Icons.keyboard_arrow_up_rounded 
                    : Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: textColor.withAlpha(190),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridActionCard({
    required String label,
    required IconData icon,
    required AppColorMode colorMode,
    required VoidCallback onTap,
  }) {
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);
    final cardBgColor = UIHelper.current.getValueAccordingToColorMode(
      colorMode: colorMode,
      darkValue: ColorFactory.darkForegroundColor,
      lightValue: Colors.white,
    );

    return OnTapScaleInteractionComponent(
      config: OnTapScaleInteractionValue(initialScale: 0.95, finalScale: 1.0),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(11),
                border: UIHelper.current.getDefaultBorder(colorMode: colorMode),
                boxShadow: [UIHelper.current.getDefaultBoxShadow()],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorFactory.accentColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: UIHelper.current.funnelTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: _showMoreOptions ? 210 : 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _showMoreOptions ? 1.0 : 0.0,
            child: ClipRect(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const SectionHeadingComponent(
                      text: "More Options",
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildGridActionCard(
                            label: "Split",
                            icon: Icons.call_split_rounded,
                            colorMode: colorMode,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Split bill option selected!",
                                    style: UIHelper.current.funnelTextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: ColorFactory.accentColor,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGridActionCard(
                            label: "Lend",
                            icon: Icons.handshake_rounded,
                            colorMode: colorMode,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Lend money option selected!",
                                    style: UIHelper.current.funnelTextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: ColorFactory.accentColor,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGridActionCard(
                            label: "Reminders",
                            icon: Icons.alarm_rounded,
                            colorMode: colorMode,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Payment reminder option selected!",
                                    style: UIHelper.current.funnelTextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: ColorFactory.accentColor,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGridActionCard(
                            label: "Family",
                            icon: Icons.people_alt_rounded,
                            colorMode: colorMode,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Family transactions option selected!",
                                    style: UIHelper.current.funnelTextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: ColorFactory.accentColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildMoreOptionsToggle(colorMode),
      ],
    );
  }
}
