import 'package:flutter/material.dart';
import 'package:vnote_client/features/questionare_screen/questionare.services.dart';

class QuestionareControllerScreen extends StatefulWidget {
  const QuestionareControllerScreen({super.key});

  @override
  State<QuestionareControllerScreen> createState() => _QuestionareControllerScreenState();
}

class _QuestionareControllerScreenState extends State<QuestionareControllerScreen> {
  final questionareServices = QuestionareServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: const Text("Questionare Screen")),
    );
  }
}
