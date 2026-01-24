import 'package:flutter/material.dart';
import 'package:vnote_client/features/registration_screen/views/registration_login_view.dart';
import 'package:vnote_client/models/frontend/segment_control.dart';
import 'package:vnote_client/shared/components/segment/segmented_controller.dart';
import 'package:vnote_client/features/registration_screen/views/registration_signup_view.dart';

class RegistrationControllerScreen extends StatefulWidget {
  const RegistrationControllerScreen({super.key});

  @override
  State<RegistrationControllerScreen> createState() => _RegistrationControllerScreenState();
}

enum RegistrationControllerScreenOptions { register, login }

class _RegistrationControllerScreenState extends State<RegistrationControllerScreen>
    with SingleTickerProviderStateMixin {
  RegistrationControllerScreenOptions selectedScreen = RegistrationControllerScreenOptions.register;

  late AnimationController _animationController;
  late Animation<Offset> _slideFromTopAnimation;
  late Animation<Offset> _slideFromBottomAnimation;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));

    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _slideFromTopAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);
    _slideFromBottomAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(curvedAnimation);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Main content
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 20, right: 20, top: 0, bottom: 0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              spacing: 0,
              children: [
                SlideTransition(
                  position: _slideFromTopAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      // Hero Image
                      Container(
                        color: Colors.blue,
                        height: 240,
                        child: Image.asset("assets/images/others/registration_screen_main.png", height: 300),
                      ),

                      // Registration Type Segment
                      Transform.translate(
                        offset: const Offset(0, -8),
                        child: SegmentedController<RegistrationControllerScreenOptions>(
                          selected: selectedScreen,
                          onSelectionChange: (newValue) {
                            setState(() {
                              selectedScreen = newValue;
                            });
                          },
                          segments: [
                            SegmentControl(value: RegistrationControllerScreenOptions.register, label: "Register"),
                            SegmentControl(value: RegistrationControllerScreenOptions.login, label: "Login"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Register and Login Views
                SlideTransition(
                  position: _slideFromBottomAnimation,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: selectedScreen == RegistrationControllerScreenOptions.register
                        ? const RegisterSignUpView(key: ValueKey("registration_screen_signup"))
                        : const RegistrationLoginView(key: ValueKey("registration_screen_login")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
