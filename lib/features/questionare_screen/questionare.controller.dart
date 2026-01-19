import 'package:flutter/material.dart';

class QuestionareControllerScreen extends StatefulWidget {
  const QuestionareControllerScreen({super.key});

  @override
  State<QuestionareControllerScreen> createState() => _QuestionareControllerScreenState();
}

class _QuestionareControllerScreenState extends State<QuestionareControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: const Text("Questionare Screen")),
    );
  }
}
