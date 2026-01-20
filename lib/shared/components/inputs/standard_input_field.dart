import 'package:flutter/material.dart';

class StandardInputField extends StatefulWidget {
  final TextEditingController textController;
  final String placeholder;
  final Icon? icon;
  const StandardInputField({super.key, required this.textController, this.placeholder = "Enter Value.", this.icon});

  @override
  State<StandardInputField> createState() => _StandardInputFieldState();
}

class _StandardInputFieldState extends State<StandardInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        fillColor: Colors.white,
        prefixIcon: widget.icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 0.3, color: Colors.black.withAlpha(5)),
          gapPadding: 0,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.5, color: Colors.black),
          gapPadding: 0,
        ),
      ),
    );
  }
}
