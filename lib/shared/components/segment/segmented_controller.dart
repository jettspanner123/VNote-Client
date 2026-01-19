import 'package:flutter/material.dart';
import 'package:vnote_client/models/frontend/segment_control.dart';
import 'package:vnote_client/shared/components/buttons/button_text.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';

class SegmentedController<SegmentType> extends StatefulWidget {
  final List<SegmentControl<SegmentType>> segments;
  final SegmentType selected;
  final ValueChanged<SegmentType> onSelectionChange;
  const SegmentedController({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelectionChange,
  });

  @override
  State<SegmentedController<SegmentType>> createState() => _SegmentedControllerState();
}

class _SegmentedControllerState<SegmentType> extends State<SegmentedController<SegmentType>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(60), width: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          spacing: 5,
          children: widget.segments.map((segment) {
            return Expanded(
              flex: 1,
              child: segment.value == widget.selected
                  ? StandardButtonComponent(
                      animationDuration: 150,
                      wantTapAnimation: false,
                      onTap: () {
                        widget.onSelectionChange(segment.value);
                      },
                      backgroundColor: segment.value == widget.selected ? Colors.black : Colors.transparent,
                      borderRadius: 8,
                      child: StandardButtonText(
                        fontSize: 13,
                        foregroundColor: segment.value == widget.selected ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        text: segment.label,
                      ),
                    )
                  : OutlineButtonComponent(
                      borderRadius: 8,
                      border: Border.all(color: Colors.black.withAlpha(60), width: 0.4),
                      onTap: () {
                        widget.onSelectionChange(segment.value);
                      },
                      child: StandardButtonText(
                        fontSize: 13,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        foregroundColor: Colors.black.withAlpha(100),
                        text: segment.label,
                      ),
                    ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
