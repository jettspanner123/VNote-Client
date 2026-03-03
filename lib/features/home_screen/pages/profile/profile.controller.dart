import 'package:flutter/material.dart';

class ProfileContorller extends StatefulWidget {
  const ProfileContorller({super.key});

  @override
  State<ProfileContorller> createState() => _ProfileContorllerState();
}

class _ProfileContorllerState extends State<ProfileContorller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(child: Text("Profile View"))),
    );
  }
}
