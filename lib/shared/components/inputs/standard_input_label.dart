import 'package:flutter/material.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class StandardInputLabelComponent extends StatefulWidget {
  final String text;
  final String? secondaryText;
  final Color foregroundColor;
  const StandardInputLabelComponent({
    super.key,
    required this.text,
    this.secondaryText,
    this.foregroundColor = Colors.black,
  });

  @override
  State<StandardInputLabelComponent> createState() => _StandardInputLabelComponentState();
}

class _StandardInputLabelComponentState extends State<StandardInputLabelComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: UIHelper.current.funnelTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: widget.foregroundColor,
              ),
            ),
            if (widget.secondaryText != null) ...[
              Text(
                widget.secondaryText!,
                style: UIHelper.current.funnelTextStyle(fontSize: 14, color: widget.foregroundColor.withAlpha(90)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
