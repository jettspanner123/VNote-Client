import 'package:flutter/material.dart';

class MainPageHolderComponent extends StatelessWidget {
  final List<Widget> children;
  const MainPageHolderComponent({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: ListView(children: children),
      ),
    );
  }
}
