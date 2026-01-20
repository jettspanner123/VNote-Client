import 'package:flutter/material.dart';
import 'package:vnote_client/features/splash_screen/splash.service.dart';

class SplashScreenController extends StatefulWidget {
  const SplashScreenController({super.key});

  @override
  State<SplashScreenController> createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController> with SingleTickerProviderStateMixin {
  final splashScreenServices = SplashScreenServices();

  late AnimationController _animationController;
  late Animation<double> _scaleUpAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastEaseInToSlowEaseOut);
    _scaleUpAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    // To Play Animation
    _animationController.forward();

    // Load data and navigate to Home Screen after a delay
    splashScreenServices.initDataLoad(context, _animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleUpAnimation,
          child: Image.asset("assets/images/others/splash_screen_logo.png", height: 200),
        ),
      ),
    );
  }
}
