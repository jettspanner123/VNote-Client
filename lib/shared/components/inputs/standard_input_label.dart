import 'package:flutter/material.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class StandardInputLabelComponent extends StatefulWidget {
  final String text;
  final String? secondaryText;
  const StandardInputLabelComponent({super.key, required this.text, this.secondaryText});

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
            Text(widget.text, style: UIHelper.current.funnelTextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            if (widget.secondaryText != null) ...[
              Text(
                widget.secondaryText!,
                style: UIHelper.current.funnelTextStyle(fontSize: 14, color: Colors.black.withAlpha(90)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
