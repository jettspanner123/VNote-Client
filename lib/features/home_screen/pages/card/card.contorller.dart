import 'package:flutter/material.dart';

class CardController extends StatefulWidget {
  const CardController({super.key});

  @override
  State<CardController> createState() => _CardControllerState();
}

class _CardControllerState extends State<CardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(child: Text("Card View"))),
    );
  }
}
