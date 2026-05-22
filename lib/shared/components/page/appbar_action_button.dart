import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class AppbarActionButton extends StatefulWidget {
    final VoidCallback? onTap;
    final Widget child;
    final Widget? expandInto;
    final double? expandHeight;
    final double? expandWidth;

    const AppbarActionButton({super.key, this.onTap, this.expandInto, required this.child, this.expandHeight, this.expandWidth});

    @override
    State<AppbarActionButton> createState() => _AppbarActionButtonState();
}

class _AppbarActionButtonState extends State<AppbarActionButton> {
    bool _isTapped = false;
    bool _isExpanded = false;

    @override
    Widget build(BuildContext context) {
        final hasExpandedState = widget.expandInto != null;
        final borderRadiusValue = hasExpandedState ? (_isExpanded ? 20.0 : 100.0) : 100.0;
        final expandedHeight = widget.expandHeight ?? 200;
        final expandedWidth = widget.expandWidth ?? 200;

        final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();

        return TapRegion(
            onTapOutside: (_) {
                if (!hasExpandedState || !_isExpanded) return;
                setState(() {
                        _isExpanded = false;
                        _isTapped = false;
                    }
                );
            },
            child: TweenAnimationBuilder<Offset>(
                tween: Tween<Offset>(end: Offset(_isExpanded ? 10 : 0, _isExpanded ? 10 : 0)),
                duration: 300.milliseconds,
                curve: Curves.fastEaseInToSlowEaseOut,
                builder: (context, offset, child) {
                    return Transform.translate(offset: offset, child: child);
                },
                child: GestureDetector(
                    onTapDown: (_) {
                        setState(() => _isTapped = true);
                        HapticFeedback.mediumImpact();
                    },
                    onTapUp: (_) {
                        widget.onTap?.call();

                        if (hasExpandedState) {
                            setState(() {
                                    _isExpanded = !_isExpanded;
                                }
                            );
                        }

                        setState(() => _isTapped = false);
                    },
                    onTapCancel: () {
                        setState(() => _isTapped = false);
                    }, 
                    child: AnimatedScale(
                        scale: _isExpanded ? 1 : _isTapped ? 0.95 : 1,
                        duration: 150.milliseconds,
                        child: AnimatedContainer(
                            duration: 300.milliseconds,
                            curve: Curves.fastEaseInToSlowEaseOut,
                            height: hasExpandedState ? (_isExpanded ? expandedHeight : 50) : 50,
                            width: hasExpandedState ? (_isExpanded ? expandedWidth : 50) : 50,
                            decoration: BoxDecoration(
                                color: UIHelper.current.getForegroundColorForColorMode(globalColorModeBloc.state.colorMode),
                                borderRadius: BorderRadius.circular(borderRadiusValue),
                                border: BoxBorder.all(color: globalColorModeBloc.state.colorMode == AppColorMode.DARK ? Colors.white.withAlpha(50) : Colors.black.withAlpha(30), width: 1),
                                boxShadow: [
                                    BoxShadow(
                                        color: UIHelper.current.getValueAccordingToColorMode(colorMode: globalColorModeBloc.state.colorMode, 
                                            darkValue: Colors.white.withAlpha(10), 
                                            lightValue: Colors.black.withAlpha(10)
                                        ),
                                        blurRadius: 10, 
                                        offset: const Offset(0, 5)
                                    )
                                ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(borderRadiusValue),
                                child: AnimatedSwitcher(
                                    duration: 200.milliseconds,
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    transitionBuilder: (child, animation) {
                                        final fadeAnimation = CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                            reverseCurve: Curves.easeIn,
                                        );
                                        final blurTween = Tween<double>(begin: 8, end: 0);

                                        return AnimatedBuilder(
                                            animation: animation,
                                            child: child,
                                            builder: (context, animatedChild) {
                                                final sigma = blurTween.evaluate(animation);
                                                return FadeTransition(
                                                    opacity: fadeAnimation,
                                                    child: ImageFiltered(
                                                        imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                                                        child: animatedChild,
                                                    ),
                                                );
                                            },
                                        );
                                    },
                                    child: Center(
                                        key: ValueKey<bool>(_isExpanded),
                                        child: hasExpandedState && _isExpanded ? widget.expandInto! : widget.child,
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}
