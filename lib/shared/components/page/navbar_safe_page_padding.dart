import 'package:flutter/material.dart';

class NavbarSafePagePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const NavbarSafePagePadding({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    var applyPadding = padding ?? EdgeInsets.only(left: 10, right: 10);
    return Padding(padding: applyPadding, child: child);
  }
}
