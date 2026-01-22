import 'package:flutter/material.dart';

class SecondaryScreenContainerComponent extends StatefulWidget {
  final List<Widget> children;
  const SecondaryScreenContainerComponent({super.key, required this.children});

  @override
  State<SecondaryScreenContainerComponent> createState() => _SecondaryScreenContainerComponentState();
}

class _SecondaryScreenContainerComponentState extends State<SecondaryScreenContainerComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: widget.children),
    );
  }
}
