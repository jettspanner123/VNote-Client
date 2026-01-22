import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';

class OtpInputField extends StatefulWidget {
  final Function(String)? onChange;
  final bool autoFocus;
  final TextEditingController textEditingController;
  final bool wantNextFocus;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onFocus;
  final VoidCallback? onFocusOut;
  const OtpInputField({
    super.key,
    this.onChange,
    this.autoFocus = false,
    required this.textEditingController,
    this.wantNextFocus = true,
    this.validator,
    this.onFocus,
    this.onFocusOut,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> with SingleTickerProviderStateMixin {
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
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        validator: widget.validator,
        focusNode: _focusNode,
        onChanged: (value) {
          widget.onChange?.call(value);
          if (value.length == 1 && widget.wantNextFocus) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: GoogleFonts.funnelSans(fontSize: 30, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        autocorrect: false,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0, fontSize: 0, color: Colors.transparent),
          hint: Text(
            "_",
            textAlign: TextAlign.center,
            style: GoogleFonts.funnelSans(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black.withAlpha(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black.withAlpha(50), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black.withAlpha(90), width: 0.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorFactory.accentColor, width: 3),
          ),
        ),
      ),
    );
  }
}
