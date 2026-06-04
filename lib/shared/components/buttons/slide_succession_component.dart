import 'package:flutter/material.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/text/color_mode_aware_text.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class SlideSuccessionComponent extends StatefulWidget {
  const SlideSuccessionComponent({super.key});

  @override
  State<SlideSuccessionComponent> createState() => _SlideSuccessionComponentState();
}

class _SlideSuccessionComponentState extends State<SlideSuccessionComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(100),
        border: BoxBorder.all(color: Colors.white.withAlpha(30), width: 1),
      ),
      height: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox.expand(
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              ColorModeAwareTextComponent(
                text: "Slide To Confirm",
                lightColor: Colors.black.withAlpha(50),
                darkColor: Colors.white.withAlpha(50),
                style: UIHelper.current.funnelTextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorFactory.accentColor,
                      border: BoxBorder.all(color: Colors.white.withAlpha(20), width: 1),
                    ),
                    child: Center(child: Icon(Icons.chevron_right, color: Colors.white, size: 30)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
