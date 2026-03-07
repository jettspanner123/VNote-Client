import 'dart:ui';
import 'package:flutter/material.dart';

class AppbarComponent extends StatefulWidget {
  final List<Widget> children;
  const AppbarComponent({super.key, required this.children});

  @override
  State<AppbarComponent> createState() => _AppbarComponentState();
}

class _AppbarComponentState extends State<AppbarComponent> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}
