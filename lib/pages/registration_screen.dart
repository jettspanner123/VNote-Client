import "package:client/store/theme_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, value, child) => Scaffold(
        body: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          color: value.currentTheme.colorScheme.surface,
          child: Row(
            children: [


              // MARK: Graphics Section

              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),



              // MARK: Content Section
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
