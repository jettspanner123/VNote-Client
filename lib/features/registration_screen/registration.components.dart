import 'package:flutter/material.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';

class RegisterSignUpView extends StatefulWidget {
  const RegisterSignUpView({super.key});

  @override
  State<RegisterSignUpView> createState() => _RegisterSignUpViewState();
}

class _RegisterSignUpViewState extends State<RegisterSignUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        StandardInputField(textController: _emailController, icon: Icon(Icons.email), placeholder: "Enter Email"),
        SizedBox(height: 10),
        StandardInputField(textController: _passwordController, icon: Icon(Icons.lock), placeholder: "Enter Password"),
        SizedBox(height: 10),
        StandardInputField(
          textController: _confirmPasswordController,
          icon: Icon(Icons.lock_outline),
          placeholder: "Confirm Password",
        ),
      ],
    );
  }
}
