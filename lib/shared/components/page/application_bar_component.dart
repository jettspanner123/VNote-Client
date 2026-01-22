import 'package:flutter/material.dart';

class ApplicationBarComponent extends StatefulWidget {
  final List<Widget> children;
  const ApplicationBarComponent({super.key, required this.children});

  @override
  State<ApplicationBarComponent> createState() => _ApplicationBarComponentState();
}

class _ApplicationBarComponentState extends State<ApplicationBarComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: widget.children),
    );
  }
}
