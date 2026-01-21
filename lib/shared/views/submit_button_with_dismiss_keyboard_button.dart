import 'package:flutter/material.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
import 'package:vnote_client/shared/components/buttons/ghost_button.dart';
import 'package:vnote_client/shared/components/buttons/outline_button.dart';
import 'package:vnote_client/shared/components/buttons/regular_button.dart';
import 'package:vnote_client/utils/keyboard_helper.dart';

class StandardButtonWithDismissKeyboardComponent extends StatefulWidget {
  final GlobalKey? globalKey;
  final VoidCallback? onTap;
  final VoidCallback? secondaryOnTap;
  final Widget child;
  final Widget? secondaryButtonChild;
  const StandardButtonWithDismissKeyboardComponent({
    super.key,
    this.globalKey,
    this.onTap,
    required this.child,
    this.secondaryButtonChild,
    this.secondaryOnTap,
  });

  @override
  State<StandardButtonWithDismissKeyboardComponent> createState() => _StandardButtonWithDismissKeyboardComponentState();
}

class _StandardButtonWithDismissKeyboardComponentState extends State<StandardButtonWithDismissKeyboardComponent>
    with WidgetsBindingObserver {
  bool isKeyboardUp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final newValue = bottomInset > 0;

    if (newValue != isKeyboardUp) {
      setState(() {
        isKeyboardUp = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 5,
              children: [
                Expanded(
                  flex: 1,
                  child: StandardButtonComponent(onTap: widget.onTap, key: widget.globalKey, child: widget.child),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isKeyboardUp
                        ? OutlineButtonComponent(
                            child: StandardButtonPadding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            onTap: () {
                              KeyboardHelper.current.dismissKeyboad(context);
                            },
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ],
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1, // expands from top
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: widget.secondaryButtonChild == null
                  ? const SizedBox.shrink(key: ValueKey("empty"))
                  : Column(
                      key: const ValueKey("secondary"),
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: GhostButtonComponent(
                            onTap: widget.secondaryOnTap,
                            child: widget.secondaryButtonChild!,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
