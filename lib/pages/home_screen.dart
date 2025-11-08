import "package:client/store/theme_provider.dart";
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
    return Consumer<ThemeModel>(
      builder: (context, value, child) =>
          Scaffold(
            body: AnimatedContainer(
              width: double.infinity,
              height: double.infinity,
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
              color: value.currentTheme.colorScheme.background,
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        value.toggleTheme();
                      },
                      child: Text("Change Theme"),
                  )
              ),
            ),
          ),
    );
  }
}
