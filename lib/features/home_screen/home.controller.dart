import 'package:flutter/material.dart';

enum HomeScreenPageOptions { ledger, payments, loan, marketing }

class HomeScreenController extends StatefulWidget {
  const HomeScreenController({super.key});

  @override
  State<HomeScreenController> createState() => _HomeScreenControllerState();
}

class _HomeScreenControllerState extends State<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [Scaffold(body: Text(""))]);
  }
}
