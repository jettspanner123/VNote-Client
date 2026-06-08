import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/interaction/tap_scale_interaction.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class _TransferMoneyUser {
  final String name;
  final String contact;
  final String initials;
  final Color avatarColor;

  const _TransferMoneyUser({
    required this.name,
    required this.contact,
    required this.initials,
    required this.avatarColor,
  });
}

class DashboardTransferMoneySelectUserController extends StatefulWidget {
  final void Function(_TransferMoneyUser user)? onUserSelected;

  const DashboardTransferMoneySelectUserController({super.key, this.onUserSelected});

  @override
  State<DashboardTransferMoneySelectUserController> createState() => _DashboardTransferMoneySelectUserControllerState();
}

class _DashboardTransferMoneySelectUserControllerState extends State<DashboardTransferMoneySelectUserController> {
  static const List<_TransferMoneyUser> _users = [
    _TransferMoneyUser(
      name: "Aarav Sharma",
      contact: "+91 98765 43210",
      initials: "AS",
      avatarColor: Color(0xFF57944D),
    ),
    _TransferMoneyUser(
      name: "Priya Mehta",
      contact: "priya.mehta@gmail.com",
      initials: "PM",
      avatarColor: Color(0xFF4A90D9),
    ),
    _TransferMoneyUser(name: "Rohan Verma", contact: "+91 91234 56789", initials: "RV", avatarColor: Color(0xFFE07B39)),
    _TransferMoneyUser(
      name: "Sneha Kapoor",
      contact: "sneha.kapoor@outlook.com",
      initials: "SK",
      avatarColor: Color(0xFF9B59B6),
    ),
    _TransferMoneyUser(name: "Karan Patel", contact: "+91 87654 32109", initials: "KP", avatarColor: Color(0xFFE74C3C)),
    _TransferMoneyUser(
      name: "Divya Nair",
      contact: "divya.nair@yahoo.com",
      initials: "DN",
      avatarColor: Color(0xFF1ABC9C),
    ),
    _TransferMoneyUser(name: "Arjun Singh", contact: "+91 99887 76655", initials: "AR", avatarColor: Color(0xFFF39C12)),
  ];

  String? _selectedName;

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            itemCount: _users.length,
            separatorBuilder: (_, __) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              final user = _users[index];
              final isSelected = _selectedName == user.name;

              return OnTapScaleInteractionComponent(
                config: OnTapScaleInteractionValue(initialScale: 0.97, finalScale: 1),
                onTap: () {
                  setState(() => _selectedName = user.name);
                  widget.onUserSelected?.call(user);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorFactory.accentColor.withAlpha(40)
                        : index.isOdd
                        ? Colors.white.withAlpha(20)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: user.avatarColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: user.avatarColor.withAlpha(80), width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            user.initials,
                            style: UIHelper.current.funnelTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: user.avatarColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: UIHelper.current.funnelTextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: UIHelper.current.getValueAccordingToColorMode(
                                  colorMode: colorMode,
                                  darkValue: Colors.white,
                                  lightValue: const Color(0xFF06140D),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user.contact,
                              style: UIHelper.current.funnelTextStyle(
                                fontSize: 13,
                                color: UIHelper.current.getValueAccordingToColorMode(
                                  colorMode: colorMode,
                                  darkValue: Colors.white54,
                                  lightValue: const Color(0xFF6D7773),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isSelected
                            ? Container(
                                key: const ValueKey('selected'),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: ColorFactory.accentColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
                              )
                            : const SizedBox(key: ValueKey('unselected'), width: 24, height: 24),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
