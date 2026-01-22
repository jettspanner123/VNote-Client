import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/shared/components/buttons/button_padding.dart';
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
                          child: ThisCancelButtonComponent(
                            onTap: widget.secondaryOnTap,
                            secondaryOnTap: widget.secondaryOnTap,
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

class ThisCancelButtonComponent extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool? isLoading;
  final double borderRadius;
  final int animationDuration;
  final Color? backgroundColor;
  final VoidCallback? secondaryOnTap;

  const ThisCancelButtonComponent({
    super.key,
    required this.child,
    this.onTap,
    this.isLoading,
    this.borderRadius = 100,
    this.animationDuration = 25,
    this.backgroundColor,
    this.secondaryOnTap,
  });

  @override
  State<ThisCancelButtonComponent> createState() => _ThisCancelButtonComponent();
}

class _ThisCancelButtonComponent extends State<ThisCancelButtonComponent> with WidgetsBindingObserver {
  bool _isTapped = false;
  bool _isClicked = false;

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
        if (newValue) {
          _isClicked = false;
        }
        isKeyboardUp = newValue;
      });
    }
  }

  void _tapDownAction(TapDownDetails _) {
    if (_isTapped) return;
    setState(() {
      _isTapped = true;
    });
    if (!_isClicked) {
      HapticFeedback.lightImpact();
    }
  }

  void _tapCancelAction() {
    if (!_isTapped) return;
    setState(() {
      _isTapped = false;
    });
  }

  void _tapUpAction(TapUpDetails _) {
    if (!_isTapped) return;
    setState(() {
      _isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDownAction,
      onTapUp: _tapUpAction,
      onTapCancel: _tapCancelAction,
      onTap: () async {
        FocusScope.of(context).unfocus();
        if (isKeyboardUp) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
        setState(() {
          _isClicked = true;
        });
      },
      child: AnimatedScale(
        scale: _isClicked
            ? 1
            : _isTapped
            ? 0.95
            : 1.0,
        duration: Duration(milliseconds: widget.animationDuration),
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.animationDuration),
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.white),
            borderRadius: BorderRadius.circular(_isClicked ? 20 : widget.borderRadius),
            color: widget.backgroundColor ?? Colors.black.withAlpha(15),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: _isClicked
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      // height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Want To Exit?",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.funnelSans(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: 5),

                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "All the progress that you have done so far, will be lost!",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.funnelSans(fontSize: 15, color: Colors.black.withAlpha(120)),
                            ),
                          ),

                          SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              spacing: 5,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlineButtonComponent(
                                    onTap: () async {
                                      await Future.delayed(const Duration(milliseconds: 200));
                                      widget.secondaryOnTap?.call();
                                    },
                                    backgroundColor: Colors.white,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "Exit",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.funnelSans(color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: StandardButtonComponent(
                                    onTap: () {
                                      setState(() {
                                        _isClicked = false;
                                      });
                                    },
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "Continue",
                                        style: GoogleFonts.funnelSans(color: Colors.white, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : widget.child,
          ),
        ),
      ),
    );
  }
}
