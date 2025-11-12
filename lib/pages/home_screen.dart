import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                },
                child: Text("Change Theme"),
            )
        ),
      ),
    );
  }
}
