import "package:flutter/material.dart";

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Container(child: Text("Login Screen")));
  }
}
