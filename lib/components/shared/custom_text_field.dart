import "package:flutter/material.dart";

class CustomInputField extends StatefulWidget {
  final TextEditingController textController;
  final bool wantLabel;
  final String labelText;
  final String placeholder;
  final FormFieldValidator<String>? validator;
  const CustomInputField({
    super.key,
    required this.textController,
    this.wantLabel = true,
    this.labelText = "",
    this.placeholder = "",
    this.validator
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MARK: Input Heading
        if (widget.wantLabel) Text(widget.labelText),

        // MARK: Input Field
        TextFormField(
          validator: widget.validator,
          controller: widget.textController,
          decoration: InputDecoration(
            labelText: widget.placeholder,
            labelStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
