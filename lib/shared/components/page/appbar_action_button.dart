import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../interaction/tap_scale_interaction.dart';

class AppbarActionButton extends StatefulWidget {
  VoidCallback? onTap;
  Widget? expandInto;
  AppbarActionButton({super.key, this.onTap, this.expandInto});

  @override
  State<AppbarActionButton> createState() => _AppbarActionButtonState();
}

class _AppbarActionButtonState extends State<AppbarActionButton> {

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return OnTapScaleInteractionComponent(
      onTap: () {
        if(widget.expandInto != null) {
          widget.onTap?.call();
          return;
        }
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      config: OnTapScaleInteractionValue.normalInteraction(),
      child: AnimatedContainer(
        duration: 300.milliseconds,
        curve: Curves.fastEaseInToSlowEaseOut,
        height: widget.expandInto == null ? 50 : _isExpanded ? 200 : 50,
        width: widget.expandInto == null ? 50 : _isExpanded ? 200 : 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_isExpanded ? 20 : 100),
          border: BoxBorder.all(color: Colors.black.withAlpha(30), width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
      ),
    );
  }
}
