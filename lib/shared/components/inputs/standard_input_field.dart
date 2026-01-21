import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardInputField extends StatefulWidget {
  final TextEditingController textController;
  final String placeholder;
  final Icon? icon;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final VoidCallback? onFocus;
  final VoidCallback? onFocusOut;
  final Widget? prefixWidget;
  final bool isDisabled;
  const StandardInputField({
    super.key,
    required this.textController,
    this.placeholder = "Enter Value.",
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onFocus,
    this.onFocusOut,
    this.prefixWidget,
    this.isDisabled = false,
  });

  @override
  State<StandardInputField> createState() => _StandardInputFieldState();
}

class _StandardInputFieldState extends State<StandardInputField> with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      widget.onFocus?.call();
    } else {
      widget.onFocusOut?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      enabled: !widget.isDisabled,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.textController,
      style: GoogleFonts.funnelSans(fontSize: 14),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        prefix: widget.prefixWidget,
        fillColor: Colors.white,
        prefixIcon: widget.icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withAlpha(90), width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withAlpha(50), width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
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
