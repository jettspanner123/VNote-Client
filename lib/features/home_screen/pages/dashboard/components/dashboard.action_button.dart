import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../utils/ui_helper.dart';
import '../helpers/dashboard.header_action.dart';

class DashboardActionButtonComponent extends StatefulWidget {
  final DashboardHeaderAction action;

  const DashboardActionButtonComponent({super.key, required this.action});

  @override
  State<DashboardActionButtonComponent> createState() => _DashboardActionButtonComponentState();
}

class _DashboardActionButtonComponentState extends State<DashboardActionButtonComponent> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Listener(
            onPointerDown: (_) {
              setState(() {
                _isTapped = true;
              });
              HapticFeedback.mediumImpact();
            },
            onPointerUp: (_) {
              setState(() {
                _isTapped = false;
              });
            },
            onPointerCancel: (_) {
              setState(() {
                _isTapped = false;
              });
            },
            child: AnimatedScale(
              scale: _isTapped ? 0.90 : 1,
              duration: 150.milliseconds,
              child: AnimatedContainer(
                duration: 150.milliseconds,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.action.accentColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black.withAlpha(30), width: _isTapped ? 5 : 1),
                ),
                child: Padding(
                  padding: widget.action.padding,
                  child: Image.asset(widget.action.iconImage, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          Text(
            widget.action.title,
            style: UIHelper.current.funnelTextStyle(color: Colors.black.withAlpha(100), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
